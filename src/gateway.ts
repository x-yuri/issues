import {
  ConnectedSocket,
  MessageBody,
  SubscribeMessage,
  WebSocketGateway,
} from '@nestjs/websockets';

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
