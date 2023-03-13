import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:company_tasks/core/play_audio_helper.dart';
import 'package:flutter/material.dart';

import '../../../features/send_message/model.dart';

class ItemRecord extends StatefulWidget {
  final Message model;
  final PlayAudioHelper playAudioHelper;

  const ItemRecord({Key? key, required this.model, required this.playAudioHelper})
      : super(key: key);

  @override
  State<ItemRecord> createState() => _ItemRecordState();
}

class _ItemRecordState extends State<ItemRecord> {
  int value = 0;

  @override
  void initState() {
    super.initState();
    widget.playAudioHelper.init(setState);
  }

  @override
  Widget build(BuildContext context) {
    widget.playAudioHelper.beforeSliderBuild();
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.yellow.withOpacity(.5),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Slider(
                            value: widget.playAudioHelper.getSliderValue(),
                            onChanged: widget.playAudioHelper.onSliderChange),
                      ),
                      IconButton(
                          onPressed: () {
                            widget.playAudioHelper.play(widget.model.body);
                          },
                          icon: Icon(
                              widget.playAudioHelper.isPlaying() ? Icons.pause : Icons.play_arrow)),
                    ],
                  ),
                  Text(widget.playAudioHelper.position!.inSeconds.toString())
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
