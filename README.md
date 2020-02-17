## The essence

The client:

```js
var socket = io('http://localhost:3000');
socket.on('connect', () => {
    socket.on('logged-in', () => {
        socket.emit('myping');
        console.log('> myping');
    });
    socket.on('mypong', () => {
        console.log('< mypong');
    });
    socket.emit('login', {username: 'admin', password: '123456'});
});
```

The server (`src/gateway.ts`):

```ts
@WebSocketGateway()
export class Gateway {
  @SubscribeMessage('login')
  login(@ConnectedSocket() client, @MessageBody() data) {
    if (data['username'] == 'admin' && data['password'] == '123456') {
      client.loggedIn = true;
      console.log('logged in');
      return {event: 'logged-in'};
    }
  }

  @SubscribeMessage('myping')
  myping(@ConnectedSocket() client, @MessageBody() data) {
    console.log('< myping');
    if (client.loggedIn) {
      console.log('> mypong');
      return {event: 'mypong'};
    }
  }
}
```

## Running locally

```
$ git clone -b nestjs-ws-auth https://github.com/x-yuri/issues nestjs-ws-auth
$ cd nestjs-ws-auth
$ npm i
$ npm run start:dev

-- console #2
$ cd client
$ npx http-server
```

### `docker`

```
$ docker run --rm -it -v $PWD:/app -w /app -p 3000:3000 node:13-alpine3.11 ./entrypoint.sh
```
