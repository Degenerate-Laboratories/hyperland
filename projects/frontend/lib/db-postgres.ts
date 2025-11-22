import { Pool } from 'pg'

let pool: Pool | null = null

export async function getPostgresDB(connectionString?: string) {
  if (!pool) {
    const dbUrl = connectionString || process.env.DATABASE_URL

    if (!dbUrl) {
      throw new Error('DATABASE_URL environment variable is not set')
    }

    pool = new Pool({
      connectionString: dbUrl,
      min: 2,
      max: 10,
    })

    // Test connection
    try {
      await pool.query('SELECT NOW()')
      console.log('✅ PostgreSQL connected')
    } catch (err) {
      console.error('❌ PostgreSQL connection failed:', err)
      throw err
    }
  }

  return pool
}

// Knex-like query builder wrapper for compatibility
export function createKnexWrapper(pool: Pool) {
  return (tableName: string) => ({
    async insert(data: any) {
      const keys = Object.keys(data)
      const values = Object.values(data)
      const placeholders = keys.map((_, i) => `$${i + 1}`).join(', ')

      const query = `INSERT INTO ${tableName} (${keys.join(', ')}) VALUES (${placeholders}) RETURNING *`
      const result = await pool.query(query, values)
      return result.rows
    },

    where(conditions: any) {
      const whereClause = Object.keys(conditions)
        .map((key, i) => `${key} = $${i + 1}`)
        .join(' AND ')
      const values = Object.values(conditions)

      return {
        async first() {
          const query = `SELECT * FROM ${tableName} WHERE ${whereClause} LIMIT 1`
          const result = await pool.query(query, values)
          return result.rows[0] || null
        },

        async delete() {
          const query = `DELETE FROM ${tableName} WHERE ${whereClause}`
          const result = await pool.query(query, values)
          return result.rowCount
        },
      }
    },
  })
}
