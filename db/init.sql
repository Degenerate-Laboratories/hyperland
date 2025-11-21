-- HyperLand PostgreSQL Schema
-- Shared database for Landing Frontend and Hyperfy service

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL DEFAULT 'Anonymous',
  avatar TEXT,
  rank INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Wallet addresses table (one-to-many with users)
CREATE TABLE wallet_addresses (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  address VARCHAR(42) NOT NULL UNIQUE,
  is_primary BOOLEAN NOT NULL DEFAULT true,
  verified_at TIMESTAMP NOT NULL DEFAULT NOW(),
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Auth challenges (for signature verification)
CREATE TABLE auth_challenges (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  address VARCHAR(42) NOT NULL,
  nonce VARCHAR(64) NOT NULL UNIQUE,
  message TEXT NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Blueprints table (from Hyperfy)
CREATE TABLE blueprints (
  id VARCHAR(255) PRIMARY KEY,
  data JSONB NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Entities table (from Hyperfy)
CREATE TABLE entities (
  id VARCHAR(255) PRIMARY KEY,
  data JSONB NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Config table (from Hyperfy)
CREATE TABLE config (
  key VARCHAR(255) PRIMARY KEY,
  value TEXT
);

-- Indexes for performance
CREATE INDEX idx_wallet_addresses_user_id ON wallet_addresses(user_id);
CREATE INDEX idx_wallet_addresses_address ON wallet_addresses(address);
CREATE INDEX idx_auth_challenges_nonce ON auth_challenges(nonce);
CREATE INDEX idx_auth_challenges_address_expires ON auth_challenges(address, expires_at);
CREATE UNIQUE INDEX idx_wallet_primary ON wallet_addresses(user_id, is_primary) WHERE is_primary = true;
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_blueprints_updated_at ON blueprints(updated_at);
CREATE INDEX idx_entities_updated_at ON entities(updated_at);

-- Insert initial config
INSERT INTO config (key, value) VALUES ('version', '0');
INSERT INTO config (key, value) VALUES
  ('settings', '{"title":null,"desc":null,"image":null,"avatar":null,"voice":"spatial","rank":0,"ao":true,"customAvatars":false}');

-- Comments for documentation
COMMENT ON TABLE users IS 'User accounts for HyperLand platform';
COMMENT ON TABLE wallet_addresses IS 'Linked wallet addresses for each user account';
COMMENT ON TABLE auth_challenges IS 'Temporary authentication challenges for wallet signature verification';
COMMENT ON TABLE blueprints IS 'Hyperfy blueprint definitions (apps, components)';
COMMENT ON TABLE entities IS 'Hyperfy world entities (instances of blueprints)';
COMMENT ON TABLE config IS 'System configuration key-value pairs';
