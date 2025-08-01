FRONTEND_DIR = ./web
BACKEND_DIR = .
BINARY_NAME = one-api

.PHONY: all build-frontend start-backend build-backend start-backend-only backend

all: build-frontend start-backend

build-frontend:
	@echo "Building frontend..."
	@cd $(FRONTEND_DIR) && bun install && DISABLE_ESLINT_PLUGIN='true' VITE_REACT_APP_VERSION=$(cat VERSION) bun run build

start-backend:
	@echo "Starting backend dev server..."
	@cd $(BACKEND_DIR) && go run main.go &

# 单独构建后端
build-backend:
	@echo "Building backend..."
	@cd $(BACKEND_DIR) && go build -o $(BINARY_NAME) main.go

# 启动不包含前端的后端服务
start-backend-only:
	@echo "Starting backend only..."
	@cd $(BACKEND_DIR) && FRONTEND_BASE_URL=http://localhost:3000 ./$(BINARY_NAME) &

# 构建并启动后端
backend: build-backend start-backend-only
