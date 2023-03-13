import 'package:audioplayers/audioplayers.dart';
import 'package:company_tasks/core/play_audio_helper.dart';
import 'package:company_tasks/features/send_message/model.dart';
import 'package:company_tasks/views/chat/components/item_record_message.dart';
import 'package:company_tasks/views/chat/components/send_message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../features/send_message/bloc.dart';
import 'components/item_text_message.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final bloc = KiwiContainer().resolve<SendMessageBloc>();
  PlayAudioHelper playAudioHelper = PlayAudioHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Amr Bakr"),
      ),
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return ListView.separated(
                reverse: true,
                itemBuilder: (context, index) => bloc.list[index].type == MessageType.record
                    ? ItemRecord(model: bloc.list[index], playAudioHelper: playAudioHelper)
                    : ItemTextMessage(model: bloc.list[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: bloc.list.length);
          }),
      bottomNavigationBar: SendMessageBox(bloc: bloc),
    );
  }
}
