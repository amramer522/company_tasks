import 'package:company_tasks/features/send_message/model.dart';
import 'package:flutter/material.dart';

class ItemTextMessage extends StatelessWidget {
  final Message model;
  const ItemTextMessage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(model.body),
      ),
    );
  }
}
