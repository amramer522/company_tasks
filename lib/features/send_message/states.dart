part of 'bloc.dart';

class SendMessageStates {}

class SendMessageLoadingState extends SendMessageStates {}

class SendMessageSuccessState extends SendMessageStates {
  final String msg;

  SendMessageSuccessState({required this.msg});
}

class SendMessageFailedState extends SendMessageStates {
  String msg;

  SendMessageFailedState({required this.msg});
}
