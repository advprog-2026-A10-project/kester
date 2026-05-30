FROM node:20-alpine
WORKDIR /app
RUN cat > server.mjs <<'JS'
import http from 'node:http';
const port = Number(process.env.PORT || 3000);
const body = `<!doctype html><html><head><meta charset="utf-8"><title>BidMart Admin</title></head><body><h1>BidMart Admin FE placeholder</h1><p>Admin API is deployed separately at admin-api. The current admin frontend branch has a client/server import build blocker.</p></body></html>`;
http.createServer((req, res) => {
  res.writeHead(200, {'content-type': 'text/html; charset=utf-8'});
  res.end(body);
}).listen(port, '0.0.0.0');
JS
EXPOSE 3000
CMD ["node", "server.mjs"]
