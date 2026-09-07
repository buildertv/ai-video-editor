# Stage 1: Build ứng dụng
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package files và cài đặt dependencies
COPY package*.json ./
RUN npm ci

# Copy toàn bộ code và build
COPY . .
RUN npm run build

# Stage 2: Phục vụ file tĩnh bằng Nginx
FROM nginx:alpine

# Copy file tĩnh đã build vào Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy cấu hình Nginx custom
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
