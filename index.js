const http = require('http');
const os = require('os');

const server = http.createServer((req, res) => {
  res.write(`IP address: ${req.socket.localAddress}\n`);
  res.write(`Hostname: ${os.hostname()}\n`);
  res.write(`App version: ${process.env.VERSION}\n`);
  res.end();
});

server.listen(3000, () => {
  console.log('Listening on port 3000');
});