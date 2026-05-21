FROM node:20-alpine AS deps
WORKDIR /app
RUN corepack enable && corepack prepare pnpm@9.15.5 --activate
COPY services/bidmart-bidding-ws/package.json services/bidmart-bidding-ws/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --prod

FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production
RUN addgroup -S app && adduser -S app -G app
COPY --from=deps /app/node_modules ./node_modules
COPY services/bidmart-bidding-ws/package.json ./
COPY services/bidmart-bidding-ws/src ./src
EXPOSE 8080
USER app
CMD ["node", "src/server.mjs"]

