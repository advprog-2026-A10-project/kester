FROM node:20-alpine AS builder
WORKDIR /app
ARG VITE_API_BASE_URL=""
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL
COPY services/bidmart-admin-fe/package.json ./
COPY services/bidmart-admin-fe/pnpm-lock.yaml* services/bidmart-admin-fe/yarn.lock* services/bidmart-admin-fe/package-lock.json* ./
RUN if [ -f pnpm-lock.yaml ]; then corepack enable && pnpm install --frozen-lockfile; \
    elif [ -f yarn.lock ]; then corepack enable && yarn install --frozen-lockfile; \
    elif [ -f package-lock.json ]; then npm ci; \
    else npm install; fi
COPY services/bidmart-admin-fe .
COPY deploy/overrides/admin-fe ./
RUN if [ -f pnpm-lock.yaml ]; then corepack enable && pnpm run build; \
    elif [ -f yarn.lock ]; then yarn build; \
    else npm run build; fi

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/build ./build
EXPOSE 3000
CMD ["./node_modules/.bin/react-router-serve", "./build/server/index.js"]
