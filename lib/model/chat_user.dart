import 'chat_base.dart';

class ChatUser extends ChatBase {
  String account;
  String nickname;
  String gender;
  ChatUser({
    required this.nickname,
    required this.account,
    this.gender = '0',
    avatar = 'assets/images/default_nor_avatar.png',
    nameIndex = '',
  }) : super(avatar: avatar, title: nickname, nameIndex: nameIndex);

  ChatUser.fromJson(Map<String, dynamic> json)
      : this(
          nickname: json['nickname'],
          account: json['account'],
          gender: '${json['gender']}',
          avatar: '${json['avatar']}',
        );

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..putIfAbsent('account', () => account)
    ..putIfAbsent('nickname', () => nickname)
    ..putIfAbsent('gender', () => gender);
}
