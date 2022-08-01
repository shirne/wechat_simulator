import 'package:flutter/material.dart';
import 'package:wechat_simulator/widgets/list_group.dart';
import '../service/logger.dart';
import '../widgets/list_cell.dart';
import '../constants.dart' show AppColors;

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_social_circle',
                  title: '朋友圈',
                  onTap: () {
                    LogUtil.i('taped');
                  },
                ),
              ],
            ),
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_quick_scan',
                  title: '扫一扫',
                  onTap: () {
                    LogUtil.i('点击了扫一扫');
                  },
                ),
                ListCell(
                  icon: 'ic_shake_phone',
                  title: '摇一摇',
                  onTap: () {},
                ),
              ],
            ),
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_feeds',
                  title: '看一看',
                  onTap: () {},
                ),
                ListCell(
                  icon: 'ic_quick_search',
                  title: '搜一搜',
                  onTap: () {},
                ),
              ],
            ),
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_people_nearby',
                  title: '附近的人',
                  onTap: () {},
                ),
                ListCell(
                  icon: 'ic_bottle_msg',
                  title: '漂流瓶',
                  onTap: () {},
                ),
              ],
            ),
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_shopping',
                  title: '购物',
                  onTap: () {},
                ),
                ListCell(
                  icon: 'ic_game_entry',
                  title: '游戏',
                  onTap: () {},
                ),
              ],
            ),
            ListGroup(
              children: [
                ListCell(
                  icon: 'ic_mini_program',
                  title: '小程序',
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
