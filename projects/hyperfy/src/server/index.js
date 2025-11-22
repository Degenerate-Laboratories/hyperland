import 'ses'
import '../core/lockdown'
import './bootstrap'

import fs from 'fs-extra'
import path from 'path'
import Fastify from 'fastify'
import ws from '@fastify/websocket'
import cors from '@fastify/cors'
import compress from '@fastify/compress'
import statics from '@fastify/static'
import multipart from '@fastify/multipart'

import { createServerWorld } from '../core/createServerWorld'
import { getDB } from './db'
import { Storage } from './Storage'
import { assets } from './assets'
import { collections } from './collections'
import { cleaner } from './cleaner'

const rootDir = path.join(__dirname, '../')
const worldDir = path.join(rootDir, process.env.WORLD)
const port = process.env.PORT

// check envs
if (!process.env.WORLD) {
  throw new Error('[envs] WORLD not set')
}
if (!process.env.PORT) {
  throw new Error('[envs] PORT not set')
}
if (!process.env.JWT_SECRET) {
  throw new Error('[envs] JWT_SECRET not set')
}
if (!process.env.ADMIN_CODE) {
  console.warn('[envs] ADMIN_CODE not set - all users will have admin permissions!')
}
if (!process.env.SAVE_INTERVAL) {
  throw new Error('[envs] SAVE_INTERVAL not set')
}
if (!process.env.PUBLIC_MAX_UPLOAD_SIZE) {
  throw new Error('[envs] PUBLIC_MAX_UPLOAD_SIZE not set')
}
if (!process.env.PUBLIC_WS_URL) {
  throw new Error('[envs] PUBLIC_WS_URL not set')
}
if (!process.env.PUBLIC_WS_URL.startsWith('ws')) {
  throw new Error('[envs] PUBLIC_WS_URL must start with ws:// or wss://')
}
if (!process.env.PUBLIC_API_URL) {
  throw new Error('[envs] PUBLIC_API_URL must be set')
}
if (!process.env.ASSETS) {
  throw new Error(`[envs] ASSETS must be set to 'local' or 's3'`)
}
if (!process.env.ASSETS_BASE_URL) {
  throw new Error(`[envs] ASSETS_BASE_URL must be set`)
}
if (process.env.ASSETS === 's3' && !process.env.ASSETS_S3_URI) {
  throw new Error(`[envs] ASSETS_S3_URI must be set when using ASSETS=s3`)
}

const fastify = Fastify({ logger: { level: 'error' } })

// create world folder if needed
await fs.ensureDir(worldDir)

// init assets
await assets.init({ rootDir, worldDir })

// init collections
await collections.init({ rootDir, worldDir })

// init db
const db = await getDB({ worldDir })

// init cleaner
await cleaner.init({ db })

// init storage
const storage = new Storage(path.join(worldDir, '/storage.json'))

// create world
const world = createServerWorld()
await world.init({
  assetsDir: assets.dir,
  assetsUrl: assets.url,
  db,
  assets,
  storage,
  collections: collections.list,
})

fastify.register(cors)
fastify.register(compress)
fastify.get('/', async (req, reply) => {
  const title = world.settings.title || 'World'
  const desc = world.settings.desc || ''
  const image = world.resolveURL(world.settings.image?.url) || ''
  const url = process.env.ASSETS_BASE_URL
  const filePath = path.join(__dirname, 'public', 'index.html')
  let html = fs.readFileSync(filePath, 'utf-8')
  html = html.replaceAll('{url}', url)
  html = html.replaceAll('{title}', title)
  html = html.replaceAll('{desc}', desc)
  html = html.replaceAll('{image}', image)
  reply.type('text/html').send(html)
})
fastify.register(statics, {
  root: path.join(__dirname, 'public'),
  prefix: '/',
  decorateReply: false,
  setHeaders: res => {
    res.setHeader('Cache-Control', 'no-cache, no-store, must-revalidate')
    res.setHeader('Pragma', 'no-cache')
    res.setHeader('Expires', '0')
  },
})
if (world.assetsDir) {
  fastify.register(statics, {
    root: world.assetsDir,
    prefix: '/assets/',
    decorateReply: false,
    setHeaders: res => {
      // all assets are hashed & immutable so we can use aggressive caching
      res.setHeader('Cache-Control', 'public, max-age=31536000, immutable') // 1 year
      res.setHeader('Expires', new Date(Date.now() + 31536000000).toUTCString()) // older browsers
    },
  })
}
fastify.register(multipart, {
  limits: {
    fileSize: 200 * 1024 * 1024, // 200MB
  },
})
fastify.register(ws)
fastify.register(worldNetwork)

const publicEnvs = {}
for (const key in process.env) {
  if (key.startsWith('PUBLIC_')) {
    const value = process.env[key]
    publicEnvs[key] = value
  }
}
const envsCode = `
  if (!globalThis.env) globalThis.env = {}
  globalThis.env = ${JSON.stringify(publicEnvs)}
`
fastify.get('/env.js', async (req, reply) => {
  reply.type('application/javascript').send(envsCode)
})

fastify.post('/api/upload', async (req, reply) => {
  const mp = await req.file()
  // collect into buffer
  const chunks = []
  for await (const chunk of mp.file) {
    chunks.push(chunk)
  }
  const buffer = Buffer.concat(chunks)
  // convert to file
  const file = new File([buffer], mp.filename, {
    type: mp.mimetype || 'application/octet-stream',
  })
  // upload
  await assets.upload(file)
})

fastify.get('/api/upload-check', async (req, reply) => {
  const exists = await assets.exists(req.query.filename)
  return { exists }
})

fastify.get('/health', async (request, reply) => {
  try {
    // Basic health check
    const health = {
      status: 'ok',
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
    }

    return reply.code(200).send(health)
  } catch (error) {
    console.error('Health check failed:', error)
    return reply.code(503).send({
      status: 'error',
      timestamp: new Date().toISOString(),
    })
  }
})

fastify.get('/status', async (request, reply) => {
  try {
    const status = {
      uptime: Math.round(world.time),
      protected: process.env.ADMIN_CODE !== undefined ? true : false,
      connectedUsers: [],
      commitHash: process.env.COMMIT_HASH,
    }
    for (const socket of world.network.sockets.values()) {
      status.connectedUsers.push({
        id: socket.player.data.userId,
        position: socket.player.position.value.toArray(),
        name: socket.player.data.name,
      })
    }

    return reply.code(200).send(status)
  } catch (error) {
    console.error('Status failed:', error)
    return reply.code(503).send({
      status: 'error',
      timestamp: new Date().toISOString(),
    })
  }
})

// Parcel Ownership API endpoints
// Get all parcels (from CSV data)
fastify.get('/api/parcels', async (request, reply) => {
  try {
    // Load and parse CSV data
    const csvPath = path.join(rootDir, '../data/BRC_ALL_1200_PARCELS.csv')
    const csvContent = await fs.readFile(csvPath, 'utf-8')
    const lines = csvContent.split('\n').filter(line => line.trim())
    const headers = lines[0].split(',')

    const parcels = []
    for (let i = 1; i < lines.length; i++) {
      const values = lines[i].split(',')
      if (values.length >= 10) {
        parcels.push({
          id: values[0],
          number: parseInt(values[1]),
          ring: values[2],
          sector: values[3],
          address: values[4].replace(/"/g, ''),
          x: parseFloat(values[5]),
          y: parseFloat(values[6]),
          latitude: parseFloat(values[7]),
          longitude: parseFloat(values[8]),
          innerRadius: parseInt(values[9]),
          outerRadius: parseInt(values[10])
        })
      }
    }

    reply.code(200).send({ parcels })
  } catch (error) {
    console.error('Error loading parcels:', error)
    reply.code(500).send({ error: 'Failed to load parcels' })
  }
})

// Get all owned parcels
fastify.get('/api/parcel-ownership', async (request, reply) => {
  try {
    const ownedParcels = await db('parcel_ownership')
      .select('*')
      .orderBy('parcelId', 'asc')

    reply.code(200).send({ ownedParcels })
  } catch (error) {
    console.error('Error fetching parcel ownership:', error)
    reply.code(500).send({ error: 'Failed to fetch parcel ownership' })
  }
})

// Purchase a parcel
fastify.post('/api/parcel-ownership/:parcelId/purchase', async (request, reply) => {
  try {
    console.log('[parcel-purchase] Request received for parcel:', request.params.parcelId)

    const { parcelId } = request.params

    // Validate parcelId format (BRC-####)
    if (!/^BRC-\d{4}$/.test(parcelId)) {
      console.log('[parcel-purchase] Invalid parcel ID:', parcelId)
      return reply.code(400).send({ error: 'Invalid parcel ID' })
    }

    // Get user from auth token
    const authHeader = request.headers.authorization
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      console.log('[parcel-purchase] Missing or invalid auth header')
      return reply.code(401).send({ error: 'Unauthorized - please log in' })
    }

    const token = authHeader.substring(7)
    const { readJWT } = await import('../core/utils-server')
    const tokenData = await readJWT(token)
    if (!tokenData) {
      return reply.code(401).send({ error: 'Invalid token' })
    }

    const userId = tokenData.id || tokenData.userId
    console.log('[parcel-purchase] User ID from token:', userId)

    // Verify user exists
    const user = await db('users').where('id', userId).first()
    if (!user) {
      console.log('[parcel-purchase] User not found in database:', userId)
      return reply.code(404).send({ error: 'User not found' })
    }

    console.log('[parcel-purchase] User found:', user.name)

    // Check if parcel is already owned
    const existingOwner = await db('parcel_ownership')
      .where('parcelId', parcelId)
      .first()

    if (existingOwner) {
      console.log('[parcel-purchase] Parcel already owned by:', existingOwner.ownerName)
      return reply.code(409).send({
        error: 'Parcel already owned',
        owner: {
          ownerId: existingOwner.ownerId,
          ownerName: existingOwner.ownerName,
          purchasedAt: existingOwner.purchasedAt
        }
      })
    }

    const moment = (await import('moment')).default
    const now = moment().toISOString()

    console.log('[parcel-purchase] Inserting ownership record for parcel', parcelId)

    // Insert ownership record - first come, first serve!
    await db('parcel_ownership').insert({
      parcelId: parcelId,
      ownerId: userId,
      ownerName: user.name,
      purchasedAt: now,
      updatedAt: now
    })

    console.log('[parcel-purchase] Ownership inserted successfully')

    // Broadcast to all connected clients that this parcel is now owned
    world.network.send('parcelPurchased', {
      parcelId: parcelId,
      ownerId: userId,
      ownerName: user.name,
      purchasedAt: now
    })

    console.log(`[parcel-ownership] User ${user.name} (${userId}) purchased parcel ${parcelId}`)

    reply.code(200).send({
      success: true,
      message: `Successfully purchased parcel ${parcelId}!`,
      ownership: {
        parcelId: parcelId,
        ownerId: userId,
        ownerName: user.name,
        purchasedAt: now
      }
    })
  } catch (error) {
    console.error('Error purchasing parcel:', error)
    reply.code(500).send({ error: 'Failed to purchase parcel' })
  }
})

fastify.setErrorHandler((err, req, reply) => {
  console.error(err)
  reply.status(500).send()
})

try {
  await fastify.listen({ port, host: '0.0.0.0' })
} catch (err) {
  console.error(err)
  console.error(`failed to launch on port ${port}`)
  process.exit(1)
}

async function worldNetwork(fastify) {
  fastify.get('/ws', { websocket: true }, (ws, req) => {
    world.network.onConnection(ws, req.query)
  })
}

console.log(`server listening on port ${port}`)

// Graceful shutdown
process.on('SIGINT', async () => {
  await fastify.close()
  process.exit(0)
})

process.on('SIGTERM', async () => {
  await fastify.close()
  process.exit(0)
})
