import Knex from 'knex'

let db = null

/**
 * Get PostgreSQL database connection
 * Shared by both Landing and Hyperfy services
 * @param {string} databaseUrl - PostgreSQL connection string
 * @returns {Promise<Knex>}
 */
export async function getPostgresDB(databaseUrl) {
  if (!db) {
    const connectionString = databaseUrl || process.env.DATABASE_URL

    if (!connectionString) {
      throw new Error('DATABASE_URL environment variable is required')
    }

    db = Knex({
      client: 'pg',
      connection: connectionString,
      pool: {
        min: parseInt(process.env.DATABASE_POOL_MIN) || 2,
        max: parseInt(process.env.DATABASE_POOL_MAX) || 10,
      },
      useNullAsDefault: false,
    })

    // Test connection
    try {
      await db.raw('SELECT 1')
      console.log('✓ PostgreSQL connected successfully')
    } catch (err) {
      console.error('✗ PostgreSQL connection failed:', err.message)
      throw err
    }
  }

  return db
}

/**
 * Close database connection
 */
export async function closeDB() {
  if (db) {
    await db.destroy()
    db = null
  }
}

/**
 * Run migrations (if needed)
 */
export async function runMigrations(db) {
  // Check if we need to run any migrations
  const hasUsersTable = await db.schema.hasTable('users')
  if (!hasUsersTable) {
    console.log('Database not initialized. Please run docker-compose up to initialize.')
    return false
  }
  return true
}
