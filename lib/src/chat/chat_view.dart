import 'package:atharo/models/chat_message.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.

class ChatView extends StatefulWidget {
  static const routeName = '/';

  ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<ChatMessage> items = [
    const ChatMessage(content: "Hello, how can I help you?", sender: MessageSender.atharo),
    const ChatMessage(content: "I need help with my order.", sender: MessageSender.user),
    const ChatMessage(content: "No problem, consider it done.", sender: MessageSender.atharo),
  ];

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var inputController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Padding(
          padding: const EdgeInsets.all(16),
          // Glue the SettingsController to the theme selection DropdownButton.
          //
          // When a user selects a theme from the dropdown list, the
          // SettingsController is updated, which rebuilds the MaterialApp.
          child: Stack(children: <Widget>[
            ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                    padding: EdgeInsets.all(14),
                    child: Align(
                      alignment: item.sender == MessageSender.user ? Alignment.topRight : Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: item.sender == MessageSender.user ? Colors.blue[200] : Colors.grey[200],
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          item.content,
                          style: const TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ));
              },
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    padding: const EdgeInsets.all(14),
                    height: 60,
                    width: double.infinity,
                    // color: Colors.white,
                    child: Row(children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: inputController,
                        focusNode: focusNode,
                        onSubmitted: (v) {
                          setState(() {
                            items.add(ChatMessage(content: inputController.text, sender: MessageSender.user));
                            inputController.clear();
                            focusNode.requestFocus();
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    items.add(ChatMessage(content: inputController.text, sender: MessageSender.user));
                                    inputController.clear();
                                    focusNode.requestFocus();
                                  });
                                },
                                icon: const Icon(Icons.send))),
                      ))
                    ])))
          ])),
    );
  }
}
