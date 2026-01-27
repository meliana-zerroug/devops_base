const http = require('http');
const os = require('os');

const getPrivateIP = () => {
  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      if (iface.family === 'IPv4' && !iface.internal) {
        return iface.address;
      }
    }
  }
  return 'unknown';
};

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end(`DevOps Base Server: ${getPrivateIP()}\n`);
});

const port = process.env.PORT || 8080;
server.listen(port,() => {
  console.log(`Listening on port ${port}`);
});

