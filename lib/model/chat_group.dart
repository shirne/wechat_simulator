import 'base.dart';
import 'chat_user.dart';

class ChatGroup extends Model {
  String title;
  String avatar;
  List<ChatUser> users;

  ChatGroup({
    required this.title,
    this.avatar = 'assets/images/ic_group_chat.png',
    required this.users,
  });

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'avatar': avatar,
        'users': users,
      };
}
