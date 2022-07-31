import 'package:flutter/material.dart';
import 'package:wechat_simulator/chat/index.dart';
import '../app_icon.dart';
import '../chat_client.dart';
import '../constants.dart' show AppColors, AppStyles, Constants;
import '../model/conversation.dart';
import '../service/logger.dart';
import '../widgets/avatar.dart';

class _ConversationItem extends StatelessWidget {
  const _ConversationItem({Key? key, required this.conversation})
      : super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    Widget avatarContainer;
    if (conversation.unreadMsgCount > 0) {
      // 未读消息角标
      Widget unreadMsgCountText = Container(
        width: Constants.unReadMsgNotifyDotSize,
        height: Constants.unReadMsgNotifyDotSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Constants.unReadMsgNotifyDotSize / 2.0),
          color: AppColors.notifyDotBgColor,
        ),
        child: Text(conversation.unreadMsgCount.toString(),
            style: AppStyles.unreadMsgCountDotStyle),
      );

      avatarContainer = Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Avatar(
            conversation.entity.avatar,
            size: Constants.conversationAvatarSize,
          ),
          Positioned(
            right: -6.0,
            top: -6.0,
            child: unreadMsgCountText,
          )
        ],
      );
    } else {
      avatarContainer = Avatar(
        conversation.entity.avatar,
        size: Constants.conversationAvatarSize,
      );
    }

    Color muteIconColor;
    if (conversation.isMute) {
      muteIconColor = AppColors.conversationMuteIconColor;
    } else {
      muteIconColor = Colors.transparent;
    }

    //勿扰模式图标
    Widget muteContainer = Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Icon(
        AppIcon.mute,
        color: muteIconColor,
        size: Constants.conversationMuteIcon,
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ChatIndexPage();
        }));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: const BoxDecoration(
          color: AppColors.conversationItemBgColor,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                avatarContainer,
                Container(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(conversation.entity.title,
                          style: AppStyles.titleStyle),
                      Text(conversation.lastMessage ?? '',
                          style: AppStyles.descStyle)
                    ],
                  ),
                ),
                Container(width: 10.0),
                Column(
                  children: [
                    Text(conversation.updateAt, style: AppStyles.descStyle),
                    muteContainer
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Constants.divider
          ],
        ),
      ),
    );
  }
}

class _DeviceInfoItem extends StatelessWidget {
  const _DeviceInfoItem({required this.device});
  final Device device;

  IconData get icon {
    return device == Device.win ? AppIcon.windows : AppIcon.mac;
  }

  String get deviceName {
    return device == Device.win ? "Windows" : "Mac";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        top: 10.0,
        right: 24.0,
        bottom: 10.0,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: Constants.dividerWidth,
              color: AppColors.dividerColor,
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 24.0,
            color: AppColors.deviceInfoItemIconColor,
          ),
          const SizedBox(width: 16.0),
          Text(
            '$deviceName 微信已登录，手机通知已关闭。',
            style: AppStyles.deviceInfoItemTextStyle,
          )
        ],
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final ConversationPageData data = ConversationPageData.mock();
  late ChatClient client;
  @override
  void initState() {
    super.initState();
    client = ChatClient.getInstance();
    client.on<ConnectStateEvent>().listen(onConnectState);
    client.on<MessageEvent>().listen(onMessage);
  }

  onMessage(MessageEvent event) {
    LogUtil.i(event);
  }

  onConnectState(ConnectStateEvent event) {
    LogUtil.i(event);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _DeviceInfoItem(device: data.device),
        ),
        SliverList(
          delegate: SliverChildListDelegate(data.conversations
              .map<Widget>((item) => _ConversationItem(conversation: item))
              .toList()),
        )
      ],
    );
  }
}
