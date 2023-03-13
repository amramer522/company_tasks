import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';

part 'events.dart';

part 'states.dart';

class SendMessageBloc extends Bloc<SendMessageEvents, SendMessageStates> {
  SendMessageBloc() : super(SendMessageStates()) {
    on<SendMessageEvent>(_sendMessage);
  }

  List<Message> list = [];

  void _sendMessage(
    SendMessageEvent event,
    Emitter<SendMessageStates> emit,
  ) async {
    emit(SendMessageLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    list.insert(0, Message(0, event.type, event.data, "10:25 PM"));
    emit(SendMessageSuccessState(msg: ""));
  }
}
