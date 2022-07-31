import '../model/chat_base.dart';

class ChatAccount extends ChatBase {
  String account;

  ChatAccount({
    required String title,
    String avatar = '',
    required this.account,
    String nameIndex = '',
  }) : super(title: title, avatar: avatar, nameIndex: nameIndex);

  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..putIfAbsent('account', () => account);
}
