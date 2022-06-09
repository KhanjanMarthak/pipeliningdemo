FROM node:16 AS builder

# set working directory
WORKDIR /app

COPY package.json ./

RUN npm install 

COPY . ./

RUN npm run build

FROM nginx:1.19.0
#copies React to the container directory
# Set working directory to nginx resources directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static resources
RUN rm -rf ./*
# Copies static resources from builder stage
COPY --from=builder /app/build .