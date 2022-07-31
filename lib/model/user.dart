import 'chat_user.dart';

class User extends ChatUser {
  User({
    required String nickname,
    required String account,
    String gender = '0',
    avatar = '',
    nameIndex = '',
  }) : super(
          nickname: nickname,
          account: account,
          gender: gender,
          avatar: avatar,
          nameIndex: nameIndex,
        );

  User.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
