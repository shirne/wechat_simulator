import 'package:flutter/material.dart';

import '../model/events.dart';
import '../model/chat_base.dart';
import '../constants.dart';
import '../model/contacts.dart';
import '../service/logger.dart';
import '../widgets/avatar.dart';

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.avatar,
    required this.title,
    this.groupTitle = '',
    this.onPressed,
  });

  final String avatar;
  final String title;
  final String groupTitle;
  final VoidCallback? onPressed;

  static const double marginVertical = 10.0;
  static const double groupTitleHeight = 24.0;

  static double _height(bool hasGroupTitle) {
    const buttonHeight = marginVertical * 2 +
        Constants.contactAvatarSize +
        Constants.dividerWidth;
    if (hasGroupTitle) {
      return buttonHeight + groupTitleHeight;
    } else {
      return buttonHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      //margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: 16.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: Constants.dividerWidth,
            color: AppColors.dividerColor,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Avatar(
            avatar,
            size: Constants.contactAvatarSize,
          ),
          const SizedBox(width: 10.0),
          Text(title),
        ],
      ),
    );

    //分组标签
    if (groupTitle.isNotEmpty) {
      return Column(
        children: <Widget>[
          Container(
            height: groupTitleHeight,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            color: AppColors.contactGroupTitleBgColor,
            alignment: Alignment.centerLeft,
            child: Text(groupTitle, style: AppStyles.groupTitleItemTextStyle),
          ),
          button,
        ],
      );
    }

    return button;
  }
}

const indexBarWords = [
  "↑",
  "☆",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  '#'
];

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Color _indexBarBgColor = Colors.transparent;
  String? _currentLetter;

  late ScrollController _scrollController;
  final ContactsPageData data = ContactsPageData.mock();
  List<ChatBase> _contacts = [];
  final List<_ContactItem> _functionButtons = [
    _ContactItem(
        avatar: 'assets/images/ic_new_friend.png',
        title: '新的朋友',
        onPressed: () {
          LogUtil.i("添加新朋友");
        }),
    _ContactItem(
        avatar: 'assets/images/ic_group_chat.png',
        title: '群聊',
        onPressed: () {
          LogUtil.i("点击了群聊");
        }),
    _ContactItem(
        avatar: 'assets/images/ic_tag.png',
        title: '标签',
        onPressed: () {
          LogUtil.i("点击了标签");
        }),
    _ContactItem(
        avatar: 'assets/images/ic_public_account.png',
        title: '公众号',
        onPressed: () {
          LogUtil.i("添加公众号");
        }),
  ];
  final Map _letterPosMap = {indexBarWords[0]: 0.0};

  @override
  void initState() {
    super.initState();
    _contacts = data.contacts;
    _scrollController = ScrollController();

    data.on<DataChangeEvent>().listen((event) {
      setState(() {
        _contacts = event.data;
      });
    });

    //计算用于 IndexBar 进行定位的关键通讯录列表项的位置
    var totalPos = _functionButtons.length * _ContactItem._height(false);
    for (var i = 0; i < _contacts.length; i++) {
      bool hasGroupTitle = true;
      if (i > 0 &&
          _contacts[i].sortIndex.compareTo(_contacts[i - 1].sortIndex) == 0) {
        hasGroupTitle = false;
      }

      if (hasGroupTitle) {
        _letterPosMap[_contacts[i].sortIndex] = totalPos;
      }
      totalPos += _ContactItem._height(hasGroupTitle);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String getLetter(BuildContext context, double tileHeight, Offset globalPos) {
    RenderBox box = context.findRenderObject() as RenderBox;
    var local = box.globalToLocal(globalPos);
    int index = (local.dy ~/ tileHeight).clamp(0, indexBarWords.length - 1);
    return indexBarWords[index];
  }

  void _jumpToIndex(String letter) {
    if (_letterPosMap.isNotEmpty) {
      final pos = _letterPosMap[letter];
      if (pos != null) {
        _scrollController.animateTo(_letterPosMap[letter],
            curve: Curves.easeInOut,
            duration: const Duration(microseconds: 200));
      }
    }
  }

  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints) {
    final List<Widget> letters = indexBarWords.map((String word) {
      return Expanded(child: Text(word));
    }).toList();

    final totalHeight = constraints.biggest.height;
    final tileHeight = totalHeight / letters.length;
    LogUtil.i(totalHeight);
    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        setState(() {
          _indexBarBgColor = Colors.black26;
          _currentLetter =
              getLetter(context, tileHeight, details.globalPosition);
          _jumpToIndex(_currentLetter!);
        });
      },
      onVerticalDragEnd: (DragEndDetails details) {
        setState(() {
          _indexBarBgColor = Colors.transparent;
          _currentLetter = null;
        });
      },
      onVerticalDragCancel: () {
        setState(() {
          _indexBarBgColor = Colors.transparent;
          _currentLetter = null;
        });
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          _currentLetter =
              getLetter(context, tileHeight, details.globalPosition);
          _jumpToIndex(_currentLetter!);
        });
      },
      child: Column(
        children: letters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = [
      ListView.builder(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (index < _functionButtons.length) {
            return _functionButtons[index];
          }
          int contactIndex = index - _functionButtons.length;
          bool isGroupTitle = true;
          ChatBase contact = _contacts[contactIndex];

          if (contactIndex >= 1 &&
              contact.sortIndex == _contacts[contactIndex - 1].sortIndex) {
            isGroupTitle = false;
          }
          return _ContactItem(
            avatar: contact.avatar,
            title: contact.title,
            groupTitle: isGroupTitle ? contact.sortIndex : '',
          );
        },
        itemCount: _contacts.length + _functionButtons.length,
      ),
      Positioned(
        width: Constants.indexBarWidth,
        right: 0.0,
        top: 30.0,
        bottom: 30.0,
        child: Container(
          color: _indexBarBgColor,
          child: LayoutBuilder(
            builder: _buildIndexBar,
          ),
        ),
      )
    ];

    if (_currentLetter != null && _currentLetter!.isNotEmpty) {
      body.add(Center(
        child: Container(
          width: Constants.indexLetterBoxSize,
          height: Constants.indexLetterBoxSize,
          decoration: const BoxDecoration(
            color: AppColors.indexLetterBoxBgColor,
            borderRadius: BorderRadius.all(
              Radius.circular(Constants.indexLetterBoxRadius),
            ),
          ),
          child: Center(
            child: Text(
              _currentLetter ?? '',
              style: AppStyles.indexLetterBoxTextStyle,
            ),
          ),
        ),
      ));
    }

    return Stack(
      children: body,
    );
  }
}
