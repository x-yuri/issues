var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);

app.get('/', function(req, res) {
    res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket) {
    socket.on('myping', () => {
        console.log('< myping');
        socket.emit('mypong');
        console.log('> mypong');
    });
});

http.listen(3000);
