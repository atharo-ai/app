import 'package:atharo/models/chat_message.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class ChatView extends StatelessWidget {
  const ChatView(
      {Key? key,
      this.items = const [
        ChatMessage(content: "Hello there!", sender: MessageSender.atharo),
        ChatMessage(content: "Can you remind me to do this thing?", sender: MessageSender.user),
        ChatMessage(content: "No problem, consider it done.", sender: MessageSender.atharo),
      ]})
      : super(key: key);

  static const routeName = '/';
  final List<ChatMessage> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
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
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ));
              },
            )
          ])),
    );
  }
}
