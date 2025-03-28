import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/widgets/message_widget.dart';
import 'package:scholar_chat/widgets/message_widget_for_friend.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessages,
  );

  final _controller = ScrollController();
  String? message;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messageList = [];

          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(
              MessageModel(
                snapshot.data!.docs[i].get(kMessage),
                snapshot.data!.docs[i].get(kDate),
                snapshot.data!.docs[i].get(kSender),
              ),
            );
          }

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
                  colors: <Color>[
                    Color.fromARGB(255, 250, 241, 157),
                    Color.fromARGB(255, 250, 252, 218),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      reverse: true,

                      itemBuilder: (context, index) {
                        return messageList[index].email == email
                            ? MessageWidget(message: messageList[index].message)
                            : MessageWidgetForFriend(
                              message: messageList[index].message,
                            );
                      },
                      itemCount: snapshot.data!.size,
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      bottom: 5,
                      top: 5,
                    ),
                    child: TextField(
                      onChanged: (value) => message = value,
                      controller: controller,
                      onSubmitted: (value) {
                        CollectionReference messages = FirebaseFirestore
                            .instance
                            .collection(kMessages);
                        messages.add({
                          'message': value,
                          'date': DateTime.now(),
                          'email': email,
                        });
                        controller.clear();
                      },
                      decoration: InputDecoration(
                        hintText: "Send a Message",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            CollectionReference messages = FirebaseFirestore
                                .instance
                                .collection(kMessages);
                            messages.add({
                              'message': message,
                              'date': DateTime.now(),
                              'email': email,
                            });
                            controller.clear();
                            _controller.animateTo(
                              _controller.position.minScrollExtent,
                              duration: Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                            );
                            print(
                              'nummmmmmmmmmmmmmmmmmmmmmmmmm ${messageList.length}',
                            );
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
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
