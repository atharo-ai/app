enum MessageSender { system, atharo, user }

class ChatMessage {
  final String content;
  final MessageSender sender;
  const ChatMessage({required this.content, required this.sender});
}
