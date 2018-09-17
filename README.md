# `socket.io`: `disconnect()` followed by `connect()`

```js
    console.log('-'.repeat(40) + ' connect');
    const socket = io();
    let connected;
    socket.on('connect', () => {
        if (connected)
            return;
        connected = true;

        console.log('-'.repeat(40) + ' disconnect');
        socket.disconnect();

        console.log('-'.repeat(40) + ' connect');
        socket.connect();
    });
```

```
---------------------------------------- connect
socket.io-client:url parse http://localhost:8082
socket.io-client new io instance for http://localhost:8082
-- new Manager (1)
-- new Manager (1): readyState = closed
-- Manager.prototype.open/connect (1)
socket.io-client:manager readyState closed
socket.io-client:manager opening http://localhost:8082
-- (engine.io) new Socket (2)
-- (engine.io) Socket.prototype.open (2)
engine.io-client:socket creating transport "websocket"
-- new WS (3)
-- new Transport (3)
-- Transport.prototype.open (3)
-- WS.prototype.doOpen (3)
** WS.prototype.doOpen (3): create websocket
engine.io-client:socket setting transport websocket
-- Manager.prototype.open/connect (1): readyState = opening
-- Manager.prototype.open/connect (1): skipReconnect = false
socket.io-client:manager connect attempt will timeout after 20000
-- (socket.io) new Socket (4)
-- (socket.io) Socket.prototype.open (4)
-- Manager.prototype.open/connect (1)
socket.io-client:manager readyState opening
engine.io-client:socket socket receive: type "open", data "{"sid":"yuyvfgszDd4nzanCAAAB","upgrades":[],"pingInterval":25000,"pingTimeout":5000}"
engine.io-client:socket socket open
socket.io-client:manager open
socket.io-client:manager cleanup
-- Manager.prototype.onopen (1): readyState = open
socket.io-client:socket transport is open - connecting
engine.io-client:socket socket receive: type "message", data "0"
socket.io-parser decoded 0 as {"type":0,"nsp":"/"}

---------------------------------------- disconnect
-- (socket.io) Socket.prototype.close/disconnect (4)
socket.io-client:socket performing disconnect (/) +1s
-- (socket.io) Socket.prototype.disconnect: this.packet({ type: parser.DISCONNECT }) (4)
socket.io-client:manager writing packet {"type":1,"nsp":"/"} +1s
socket.io-parser encoding packet {"type":1,"nsp":"/"} +1s
socket.io-parser encoded {"type":1,"nsp":"/"} as 1
engine.io-client:socket flushing 1 packets in socket +1s
-- (socket.io) Socket.prototype.destroy (4)
-- Manager.prototype.close/disconnect (1)
socket.io-client:manager disconnect
-- Manager.prototype.close/disconnect (1): skipReconnect = true
-- Manager.prototype.close/disconnect (1): readyState = closed
-- (engine.io) Socket.prototype.close (2)
socket.io-client:socket close (io client disconnect)

---------------------------------------- connect
-- (socket.io) Socket.prototype.open (4)
-- Manager.prototype.open/connect (1)
socket.io-client:manager readyState closed
socket.io-client:manager opening http://localhost:8082
-- (engine.io) new Socket (5)
-- (engine.io) Socket.prototype.open (5)
engine.io-client:socket creating transport "websocket"
-- new WS (6)
-- new Transport (6)
-- Transport.prototype.open (6)
-- WS.prototype.doOpen (6)
** WS.prototype.doOpen (6): create websocket
engine.io-client:socket setting transport websocket
-- Manager.prototype.open/connect (1): readyState = opening
-- Manager.prototype.open/connect (1): skipReconnect = false
socket.io-client:manager connect attempt will timeout after 20000

// continue closing...
-- (engine.io) Socket.prototype.close: once: drain (2)
engine.io-client:socket socket close with reason: "forced close"
-- Transport.prototype.close (3)
-- WS.prototype.doClose (3)
** WS.prototype.doClose (3): close websocket
socket.io-client:manager onclose
socket.io-client:manager cleanup
-- Manager.prototype.onclose (1): readyState = closed
socket.io-client:socket close (forced close)

// reconnect since skipReconnect was set to false by Manager.prototype.open/connect
-- Manager.prototype.reconnect
socket.io-client:manager will wait 866ms before reconnect attempt
engine.io-client:socket socket closing - telling transport to close
-- Transport.prototype.close (3)

// continue opening...
engine.io-client:socket socket receive: type "open", data "{"sid":"O4zFfUIR63fc2cxVAAAC","upgrades":[],"pingInterval":25000,"pingTimeout":5000}"
engine.io-client:socket socket open
engine.io-client:socket socket receive: type "message", data "0"

// continue closing, or rather reconnecting...
socket.io-client:manager attempting reconnect
-- Manager.prototype.open/connect (1)
socket.io-client:manager readyState closed
socket.io-client:manager opening http://localhost:8082

// at this point we're losing reference to the previous (second, 5) connection
-- (engine.io) new Socket (7)
-- (engine.io) Socket.prototype.open (7)
engine.io-client:socket creating transport "websocket"
-- new WS (8)
-- new Transport (8)
-- Transport.prototype.open (8)
-- WS.prototype.doOpen (8)
** WS.prototype.doOpen (8): create websocket
engine.io-client:socket setting transport websocket
-- Manager.prototype.open/connect (1): readyState = opening
-- Manager.prototype.open/connect (1): skipReconnect = false
socket.io-client:manager connect attempt will timeout after 20000
engine.io-client:socket socket receive: type "open", data "{"sid":"Qlz-oHASaXms3Oq9AAAD","upgrades":[],"pingInterval":25000,"pingTimeout":5000}"
engine.io-client:socket socket open
socket.io-client:manager open
socket.io-client:manager cleanup
-- Manager.prototype.onopen (1): readyState = open
socket.io-client:socket transport is open - connecting
socket.io-client:manager reconnect success
engine.io-client:socket socket receive: type "message", data "0"
socket.io-parser decoded 0 as {"type":0,"nsp":"/"}
```

## Solution

Use `io()` instead:

```js
    let socket = io();
    socket.on('connect', () => {
        socket.emit('test');

        socket = io();
        socket.on('connect', () => {
            socket.emit('test 2');
        });
    });
```

## Running locally

```
$ git clone -b socket-io-disconnect-connect https://github.com/x-yuri/issues socket-io-disconnect-connect
$ cd socket-io-disconnect-connect
$ ./up.sh
// or
$ npm i
$ node server.js
```
