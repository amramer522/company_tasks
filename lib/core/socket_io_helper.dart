// import 'package:socket_io/socket_io.dart';
//
// class SocketIOHelper {
//   final io = Server();
//
//
//   var socket = io("connection url to server",
//       {
//         // here add is a map containing options
//         "transports": ['websocket'],
//         "force new connection": true
//       });
//
//
//   listenToEvent(String eventName) {
//     // handle  called everytime the event is received
//     // data is the data which came with the event
//     io.on(eventName, (data) {
//
//
//     });
//   }
//
//   listenToConnection() {
//     // connection event is received every time the client connect the server
//     // client is a reference to the client socket
//     io.on("connection", (client) {
//       // you can listen for specific event form this client instead of the server
//       client.on("eventName", (data) {});
//       // to move client into a room
//       client.join("roomName");
//       // for sending or emitting event use
//       // in this example will send the event to this specific client
//       client.emit("eventName", dataObject);
//       // to send event to all the people except this client
//       client.broadcast.emit();
//
//
//       // if you want to send event for all the connected client
//       io.emit("event", data)
//
//       // if you want to send events to room
//       client.to("roomName").emit("event");
//       // if you want to send events to more than one room
//       client.to("roomName1").to("roomName2").emit("event");
//
//       //calling the emit function on the socket(client) will not send the event to this client
//       // but the server object will
//       io.to("roomName1").to("roomName2").emit("event");
//
//       // before emitting an event a unit operation is performed on the clients that receive the event
//       // so that every event is only received once by each client
//       // {1,2,3} unit(الاتحاد) {1,2,3,4} = {1,2,3,4}
//
//
//       // to actually start listening to events all you have to do is call the listen function and specify the port
//       io.listen("port");
//
//       //before you start implementing the client you have to look at what version of socket IO your server is running
//       /*
//       if your server with dart it runs version 2, however the newest versions are 3 , 4
//       and they are not backwards compatible so there are two versions of the socket IO client package (socket_io_client)
//       version 1  of the client   is compatible with version 2 of socket IO
//       while version 2  of the client is compatible with version 3 and 4
//       so choose the correct dependency and add it to your pubspec.yaml
//        */
//
//       socket.onConnect(handler);
//
//
//     });
//   }
//
//
// }
