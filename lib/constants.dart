import 'package:flutter/material.dart';

import 'app_icon.dart';

class AppColors {
  static const tabIconNormal = Color(0xff999999);
  static const tabIconActive = Color(0xff46c11b);
  static const appBarPopupMenuColor = Color(0xffffffff);
  static const conversationItemBgColor = Color(0xffffffff);
  static const descTextColor = Color(0xff9e9e9e);
  static const dividerColor = Color(0xffd9d9d9);
  static const conversationMuteIconColor = Color(0xffd8d8d8);
  static const deviceInfoItemBgColor = Color(0xfff5f5f5);
  static const deviceInfoItemTextColor = Color(0xff606062);
  static const deviceInfoItemIconColor = Color(0xff606062);
  static const contactGroupTitleBgColor = Color(0xffebebeb);
  static const contactGroupTitleColor = Color(0xff888888);
  static const indexLetterBoxBgColor = Colors.black45;
}

class AppStyles {
  static const deviceInfoItemTextStyle = TextStyle(
    fontSize: 13.0,
    color: AppColors.deviceInfoItemTextColor,
  );
  static const groupTitleItemTextStyle =
      TextStyle(color: AppColors.contactGroupTitleColor, fontSize: 14.0);

  static const indexLetterBoxTextStyle = TextStyle(
    fontSize: 64.0,
    color: Colors.white,
  );
}

class Constants {
  static const conversationAvatarSize = 48.0;
  static const dividerWidth = 0.5;
  static const unReadMsgNotifyDotSize = 20.0;
  static const conversationMuteIcon = 18.0;
  static const contactAvatarSize = 36.0;
  static const indexBarWidth = 24.0;
  static const indexLetterBoxSize = 114.0;
  static const indexLetterBoxRadius = 4.0;
  static const fullWidthIconButtonIconSize = 24.0;
  static const profileHeaderIconSize = 60.0;

  static const chatServer = 'ws://127.0.0.1:8080';

  static const conversationAvatarDefaultIcon = Icon(
    AppIcon.avatar,
    size: conversationAvatarSize,
  );

  static const contactAvatarDefaultIcon = Icon(
    AppIcon.avatar,
    size: contactAvatarSize,
  );

  static const profileAvatarDefaultIcon = Icon(
    AppIcon.avatar,
    size: profileHeaderIconSize,
  );

  static const divider = Divider(
    height: 0.5,
    thickness: 0.5,
    indent: 50,
    endIndent: 0,
  );
}
