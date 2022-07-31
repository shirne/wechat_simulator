import 'package:flutter/material.dart' hide MenuItem;

import '../app_icon.dart';
import '../service/logger.dart';
import 'menu_item.dart';

enum ActionItems { groupChat, addFriend, qrScan, payment }

class ToolbarPage extends StatefulWidget {
  final Widget child;

  const ToolbarPage({Key? key, required this.child}) : super(key: key);

  @override
  State<ToolbarPage> createState() => _ToolbarPageState();
}

class _ToolbarPageState extends State<ToolbarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('微信'),
        elevation: 0.0, //不需要阴影
        actions: <Widget>[
          IconButton(
            icon: const Icon(AppIcon.search),
            onPressed: () {
              LogUtil.i('点击了搜索按钮');
            },
          ),
          Container(width: 16.0),
          PopupMenuButton(
            color: Colors.black,
            tooltip: '打开菜单',
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: ActionItems.groupChat,
                  child: MenuItem(icon: AppIcon.bubble, title: "发起群聊"),
                ),
                PopupMenuItem(
                  value: ActionItems.addFriend,
                  child: MenuItem(icon: AppIcon.contactAdd, title: "添加朋友"),
                ),
                PopupMenuItem(
                  value: ActionItems.qrScan,
                  child: MenuItem(icon: AppIcon.scan, title: "扫一扫"),
                ),
                PopupMenuItem(
                  value: ActionItems.payment,
                  child: MenuItem(icon: AppIcon.payment, title: "收付款"),
                ),
              ];
            },
            icon: const Icon(
              AppIcon.plus,
              size: 22.0,
            ),
            onSelected: (ActionItems selected) {
              LogUtil.i('点击的是$selected');
            },
          ),
          Container(width: 16.0)
        ],
      ),
      body: widget.child,
    );
  }
}
