import 'package:company_tasks/core/record_audio_helper.dart';
import 'package:company_tasks/features/send_message/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../features/send_message/bloc.dart';

class SendMessageBox extends StatefulWidget {
  final SendMessageBloc bloc;

  const SendMessageBox({Key? key, required this.bloc}) : super(key: key);

  @override
  State<SendMessageBox> createState() => _SendMessageBoxState();
}

class _SendMessageBoxState extends State<SendMessageBox> with SingleTickerProviderStateMixin {
  final msgController = TextEditingController();
  double scale = 1;
  double xPosition = 0;
  late AnimationController _controller;

  final myRecorder = RecordAudioHelper();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _controller.drive(tween);

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      setState(() {});
    });
  }

  Tween<double> tween = Tween(begin: 1, end: -1);

  @override
  Widget build(BuildContext context) {
    print(myRecorder.isRecord());

    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: 16, end: 16, top: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Row(
        children: [
          Expanded(
              child: scale <= 1
                  ? TextFormField(
                      controller: msgController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.green[600],
                          hintText: "Message",
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(end: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.attach_file, color: Colors.black),
                                if (msgController.text.isEmpty)
                                  SizedBox(
                                    width: 10,
                                  ),
                                if (msgController.text.isEmpty)
                                  Icon(
                                    Icons.image,
                                    color: Colors.black,
                                  ),
                              ],
                            ),
                          )),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.green, borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) => AnimatedOpacity(
                              opacity: _controller.value,
                              duration: const Duration(milliseconds: 200),
                              onEnd: () {
                                _controller.reset();
                              },
                              child: const Icon(
                                Icons.fiber_manual_record,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey.withOpacity(.9),
                            size: 14,
                          ),
                          Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.grey,
                              direction: ShimmerDirection.rtl,
                              child: const Text("Slide to cancel"))
                        ],
                      ),
                    )),
          const SizedBox(
            width: 10,
          ),
          BlocConsumer(
              bloc: widget.bloc,
              listener: (context, state) {
                if (state is SendMessageLoadingState) {
                  msgController.clear();
                  setState(() {});
                }
              },
              builder: (context, state) {
                if (state is SendMessageLoadingState) {
                  return CircularProgressIndicator();
                }
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print("onTap");
                      print(myRecorder.isRecord());

                      if (msgController.text.isNotEmpty) {
                        widget.bloc.add(
                            SendMessageEvent(type: MessageType.text, data: msgController.text));
                      }
                    },
                    onPanStart: (details) async {
                      debugPrint("onPanStart");
                      while (scale <= 2) {
                        scale += .1;
                        _controller.forward();
                        setState(() {});
                      }
                    },
                    onPanDown: (details) async {
                      debugPrint("onPanDown");
                      await myRecorder.start(setState);

                      print(myRecorder.isRecord());

                      while (scale <= 2) {
                        scale += .1;
                        _controller.forward();
                        setState(() {});
                      }
                    },
                    onPanEnd: (details) async {
                      debugPrint("onPanEnd");
                      await myRecorder.stop();
                      // await record.stop();
                      print(myRecorder.isRecord());

                      xPosition = 0;
                      _controller.reset();
                      while (scale >= 1) {
                        scale -= .1;
                        _controller.reverse();
                        xPosition = 0;
                        setState(() {});
                      }
                    },
                    onPanCancel: () async {
                      debugPrint("onPanCancel");

                      widget.bloc.add(SendMessageEvent(
                          data: await myRecorder.stop() ?? "", type: MessageType.record));
                      print(myRecorder.isRecord());
                      xPosition = 0;
                      _controller.reset();
                      while (scale >= 1) {
                        scale -= .1;
                        // _controller.reset();
                        _controller.reverse();
                        xPosition = 0;
                        setState(() {});
                      }
                    },
                    onPanUpdate: (details) {
                      debugPrint("onPanUpdate");
                      debugPrint((MediaQuery.of(context).size.width / 2).toString());
                      xPosition = details.localPosition.dx;
                      if (xPosition <= -1 * MediaQuery.of(context).size.width / 2) {
                        xPosition = 0;
                        scale = 1;
                        _controller.reset();
                      }
                      print(myRecorder.isRecord());

                      setState(() {});
                      debugPrint(details.delta.dx.toString());
                      debugPrint(details.localPosition.dx.toString());
                      // }
                    },
                    child: Transform.translate(
                      offset: Offset(xPosition, 0),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: scale,
                            child: CircleAvatar(
                              child: Icon(
                                  msgController.text.isEmpty ? Icons.settings_voice : Icons.send),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
