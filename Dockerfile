# Stage 1: Build the application
FROM node:20-alpine AS builder
WORKDIR /app
COPY ./node-hello/ ./
RUN npm install

# Stage 2: Run the application
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
CMD ["node", "index.js"]
