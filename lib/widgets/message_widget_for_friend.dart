import 'package:flutter/material.dart';

class MessageWidgetForFriend extends StatelessWidget {
  const MessageWidgetForFriend({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 73, 217, 236),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Text(message),
      ),
    );
  }
}
