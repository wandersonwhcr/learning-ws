const express = require('express');
const http = require('http');
const morgan = require('morgan');
const socket = require('socket.io');

const app    = express();
const server = http.Server(app);
const io     = socket(server);

app.use(morgan('tiny'));
app.use(express.static('public'));
app.use('/socket.io.js', express.static(__dirname + '/node_modules/socket.io-client/dist/socket.io.js'));

io.on('connection', (socket) => {
    // Message Capture!
    socket.on('message', (message) => {
        // Broadcasting
        io.emit('message', message);
    });
});

server.listen(8000);
