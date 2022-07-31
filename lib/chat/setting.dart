import 'package:flutter/material.dart';

class ChatSettingPage extends StatefulWidget {
  const ChatSettingPage({Key? key}) : super(key: key);

  @override
  State<ChatSettingPage> createState() => _ChatSettingPageState();
}

class _ChatSettingPageState extends State<ChatSettingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('ChatSetting')),
    );
  }
}
