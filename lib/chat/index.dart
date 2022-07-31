import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/chat_user.dart';
import '../model/chat_group.dart';

class ChatIndexPage extends StatelessWidget {
  final bool isGroup;
  final ChatGroup? group;
  final ChatUser? user;

  ChatIndexPage({Key? key, this.isGroup = false, this.group, this.user})
      : super(key: key) {
    assert(isGroup ? group != null : user != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user?.nickname ?? group!.title),
      ),
      body: isGroup ? ChatGroupPage(group!) : ChatUserPage(user!),
    );
  }
}

class ChatUserPage extends StatefulWidget {
  final ChatUser user;
  const ChatUserPage(this.user, {Key? key}) : super(key: key);

  @override
  State<ChatUserPage> createState() => _ChatUserPageState();
}

class _ChatUserPageState extends State<ChatUserPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
          children: const [
            Text('chat1'),
            Text('chat2'),
          ],
        )),
        const ChatFloor()
      ],
    );
  }
}

class ChatGroupPage extends StatefulWidget {
  final ChatGroup group;
  const ChatGroupPage(this.group, {Key? key}) : super(key: key);

  @override
  State<ChatGroupPage> createState() => _ChatGroupPageState();
}

class _ChatGroupPageState extends State<ChatGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
          children: const [
            Text('chat1'),
            Text('chat2'),
          ],
        )),
        const ChatFloor()
      ],
    );
  }
}

class ChatFloor extends StatefulWidget {
  const ChatFloor({Key? key}) : super(key: key);

  @override
  State<ChatFloor> createState() => _ChatFloorState();
}

class _ChatFloorState extends State<ChatFloor> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.dot_radiowaves_right),
            ),
            const Expanded(child: TextField()),
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.smiley)),
            IconButton(
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                icon: const Icon(CupertinoIcons.plus))
          ],
        ),
        expanded ? const ChatPlusFunctions() : const SizedBox(height: 0)
      ],
    );
  }
}

class ChatPlusFunctions extends StatelessWidget {
  const ChatPlusFunctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 100,
    );
  }
}
