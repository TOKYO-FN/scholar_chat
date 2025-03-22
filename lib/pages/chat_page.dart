import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/message_widget.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  String? message;

  TextEditingController controller = TextEditingController();
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', height: 50),
            Text("Chat"),
          ],
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xffC7EDE9), Color(0xffC7EDE9)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemBuilder:
                    (context, index) => MessageWidget(
                      message:
                          'hello from index $index hello from index $index hello from index $index hello from index $index hello from index $index hello from index $index hello from index $index hello from index $index hello from index $index',
                    ),
                itemCount: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                right: 10,
                left: 10,
                bottom: 20,
              ),
              child: TextField(
                onChanged: (value) => message = value,
                controller: controller,
                onSubmitted: (value) {
                  CollectionReference messages = FirebaseFirestore.instance
                      .collection(kMessages);
                  messages.add({'message': value});
                  controller.clear();
                },
                decoration: InputDecoration(
                  hintText: "Send a Message",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      CollectionReference messages = FirebaseFirestore.instance
                          .collection(kMessages);
                      messages.add({'message': message});
                      controller.clear();
                    },
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
