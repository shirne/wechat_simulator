import 'package:flutter/cupertino.dart';

import '../constants.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const MenuItem({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 22.0,
          color: AppColors.appBarPopupMenuColor,
        ),
        Container(width: 12.0),
        Text(
          title,
          style: const TextStyle(color: AppColors.appBarPopupMenuColor),
        ),
      ],
    );
  }
}
