import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../widgets/avatar.dart';
import '../widgets/list_group.dart';
import '../widgets/list_cell.dart';
import '../app_icon.dart';
import '../constants.dart' show AppColors, Constants;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _ProfileHeaderView(context.watch<User>()),
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_wallet',
                  title: '钱包',
                  onTap: () {},
                ),
              ],
            ),
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_collections',
                  title: '收藏',
                  onTap: () {},
                ),
                ListCell(
                  icon: 'ic_album',
                  title: '相册',
                  onTap: () {},
                ),
                ListCell(
                  icon: 'ic_cards_wallet',
                  title: '卡包',
                  onTap: () {},
                ),
                ListCell(
                  icon: 'ic_emotions',
                  title: '表情',
                  onTap: () {},
                ),
              ],
            ),
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_settings',
                  title: '设置',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeaderView extends StatelessWidget {
  static const horizontalPadding = 20.0;
  static const verticalPadding = 13.0;

  final User user;

  const _ProfileHeaderView(this.user, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Avatar(
            user.avatar,
            size: Constants.profileHeaderIconSize,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(user.nickname,
                    style: const TextStyle(
                      color: AppColors.titleColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 10.0),
                Text(
                  '微信号: ${user.account}',
                  style: const TextStyle(
                    color: AppColors.descTextColor,
                    fontSize: 13.0,
                  ),
                )
              ],
            ),
          ),
          const Icon(
            AppIcon.qrcode,
            size: 22.0,
            color: AppColors.tabIconNormal,
          ),
          const SizedBox(width: 5.0),
          const Icon(
            AppIcon.arrowRight,
            size: 22.0,
            color: AppColors.tabIconNormal,
          ),
        ],
      ),
    );
  }
}
