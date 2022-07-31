import 'package:flutter/material.dart';

import '../app_icon.dart';
import '../constants.dart';

class ListCell extends StatelessWidget {
  final String? icon;
  final String title;
  final GestureTapCallback? onTap;

  const ListCell({Key? key, this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      //contentPadding: EdgeInsets.all(0),
      //dense:true,
      tileColor: Colors.white,
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      leading: Image.asset(
        "assets/images/$icon.png",
        width: Constants.fullWidthIconButtonIconSize,
        height: Constants.fullWidthIconButtonIconSize,
      ),
      title: Text(title),
      trailing: const Icon(
        AppIcon.arrowRight,
        size: 22.0,
        color: AppColors.tabIconNormal,
      ),
      onTap: onTap,
    );
  }
}
