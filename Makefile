.PHONY: help init install build dev start test clean landing hyperfy all kill-ports db-up db-down db-reset db-logs db-shell

# Colors for output
GREEN  := \033[0;32m
YELLOW := \033[0;33m
BLUE   := \033[0;34m
RED    := \033[0;31m
NC     := \033[0m # No Color

# Port configuration
HYPERFY_PORT := 4000
LANDING_PORT := 4001

help: ## Show this help message
	@echo '${GREEN}HyperLand Monorepo - Makefile Commands${NC}'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  ${YELLOW}%-20s${NC} %s\n", $$1, $$2}'
	@echo ''

# Database commands
db-up: ## Start PostgreSQL database
	@echo "${GREEN}Starting PostgreSQL...${NC}"
	docker-compose up -d postgres
	@echo "${YELLOW}Waiting for PostgreSQL to be ready...${NC}"
	@sleep 3
	@echo "${GREEN}✓ PostgreSQL is ready at localhost:5432${NC}"

db-down: ## Stop PostgreSQL database
	@echo "${YELLOW}Stopping PostgreSQL...${NC}"
	docker-compose down
	@echo "${GREEN}✓ PostgreSQL stopped${NC}"

db-reset: ## Reset database (WARNING: deletes all data)
	@echo "${RED}Resetting database (all data will be lost)...${NC}"
	docker-compose down -v
	docker-compose up -d postgres
	@sleep 3
	@echo "${GREEN}✓ Database reset complete${NC}"

db-logs: ## Show PostgreSQL logs
	docker-compose logs -f postgres

db-shell: ## Connect to PostgreSQL shell
	docker-compose exec postgres psql -U hyperland -d hyperland_dev

init: ## Initialize git submodules
	@echo "${GREEN}Initializing submodules...${NC}"
	git submodule update --init --recursive
	@echo "${GREEN}✓ Submodules initialized${NC}"

install: init ## Install all dependencies (landing page + hyperfy)
	@echo "${BLUE}Installing landing page dependencies...${NC}"
	cd projects/frontend && npm install
	@echo "${GREEN}✓ Landing page dependencies installed${NC}"
	@echo "${BLUE}Installing hyperfy dependencies...${NC}"
	cd projects/hypery-hyperland/frontend && npm install
	@echo "${GREEN}✓ All dependencies installed${NC}"

build: ## Build all projects (landing page + hyperfy)
	@echo "${BLUE}Building landing page...${NC}"
	cd projects/frontend && npm run build
	@echo "${BLUE}Building hyperfy...${NC}"
	cd projects/hypery-hyperland/frontend && npm run build
	@echo "${GREEN}✓ All projects built${NC}"

kill-ports: ## Kill any processes running on ports 4000 and 4001
	@echo "${YELLOW}Killing processes on ports ${HYPERFY_PORT} and ${LANDING_PORT}...${NC}"
	@lsof -ti:$(HYPERFY_PORT) | xargs kill -9 2>/dev/null || true
	@lsof -ti:$(LANDING_PORT) | xargs kill -9 2>/dev/null || true
	@echo "${GREEN}✓ Ports cleared${NC}"

dev: kill-ports ## Start both landing page AND hyperfy in development mode
	@echo "${GREEN}Starting landing page and hyperfy development servers...${NC}"
	@echo "${YELLOW}Hyperfy will be on http://localhost:${HYPERFY_PORT}${NC}"
	@echo "${YELLOW}Landing page will be on http://localhost:${LANDING_PORT}${NC}"
	@$(MAKE) -j2 landing hyperfy

start: dev ## Alias for dev (starts both services)

landing: ## Start landing page dev server (port 4001)
	@echo "${BLUE}[Landing] Starting on port ${LANDING_PORT}...${NC}"
	@cd projects/frontend && PORT=$(LANDING_PORT) npm run dev

hyperfy: ## Start hyperfy dev server (port 4000)
	@echo "${BLUE}[Hyperfy] Starting on port ${HYPERFY_PORT}...${NC}"
	@cd projects/hypery-hyperland/frontend && PORT=$(HYPERFY_PORT) npm run dev

test: ## Run all tests
	@echo "${BLUE}Running contract tests...${NC}"
	cd contracts && forge test -vv
	@echo "${GREEN}✓ All tests complete${NC}"

clean: ## Clean build artifacts
	@echo "${YELLOW}Cleaning build artifacts...${NC}"
	cd projects/frontend && rm -rf .next out node_modules/.cache
	cd contracts && forge clean
	@echo "${GREEN}✓ Cleaned${NC}"

update: ## Update submodules to latest
	@echo "${GREEN}Updating submodules...${NC}"
	git submodule update --remote --recursive
	@echo "${GREEN}✓ Submodules updated${NC}"

status: ## Show git status including submodules
	@echo "${GREEN}Main repository status:${NC}"
	git status
	@echo ""
	@echo "${GREEN}Submodule status:${NC}"
	git submodule status

# Development workflow
setup: init install ## Full setup (init + install all dependencies)
	@echo "${GREEN}✓ Setup complete! Run 'make start' to run both services${NC}"

all: build ## Build everything

.DEFAULT_GOAL := help
