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

let counter = 0;

io.on('connection', (socket) => {
    // Counter!
    io.emit('message', `New Connection. Current: ${++counter} Users`);

    // Message Capture!
    socket.on('message', (message) => {
        // Send Message to Everyone
        io.emit('message', message);
    });

    // Disconnected
    socket.on('disconnect', () => {
        // Counter!
        io.emit('message', `Disconnected. Current: ${--counter} Users`);
    });
});

server.listen(8000);
