part of 'bloc.dart';

class SendMessageEvents {}

class SendMessageEvent extends SendMessageEvents {
  final String data;
  final MessageType type;

  SendMessageEvent({required this.data,required this.type});
}
