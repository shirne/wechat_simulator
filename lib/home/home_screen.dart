import 'package:flutter/material.dart';
import 'package:shirne_dialog/shirne_dialog.dart';
import '../chat_client.dart';
import '../service/logger.dart';
import '../widgets/toolbar_page.dart';
import '../app_icon.dart';
import '../constants.dart';
import 'conversation_page.dart';
import 'contacts_page.dart';
import 'discover_page.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late List<Widget> _pages;
  int _currentIndex = 0;

  late ChatClient client;

  @override
  void initState() {
    super.initState();
    client = ChatClient.getInstance();
    client.on<MessageEvent>().listen(onMessage);
    client.on<LoginStateEvent>().listen(onLoginState);

    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      const ToolbarPage(child: ConversationPage()),
      const ToolbarPage(child: ContactsPage()),
      const ToolbarPage(child: DiscoverPage()),
      const ProfilePage(),
    ];
  }

  onMessage(MessageEvent event) {
    LogUtil.i(event);
  }

  onLoginState(LoginStateEvent event) {
    LogUtil.i(event);
    MyDialog.confirm('登录失败，重新登录？').then((value) => client.connect());
  }

  BottomNavigationBarItem navigationIconView({
    required String title,
    required IconData icon,
    required IconData activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: title,
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          print(index);
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: AppColors.tabIconActive,
        selectedFontSize: 12,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
            // _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
          });
        },
        items: [
          navigationIconView(
            title: '微信',
            icon: AppIcon.chat,
            activeIcon: AppIcon.chatFill,
          ),
          navigationIconView(
            title: '通讯录',
            icon: AppIcon.contacts,
            activeIcon: AppIcon.contactsFill,
          ),
          navigationIconView(
            title: '发现',
            icon: AppIcon.discovery,
            activeIcon: AppIcon.discoveryFill,
          ),
          navigationIconView(
            title: '我',
            icon: AppIcon.my,
            activeIcon: AppIcon.myFill,
          ),
        ],
      ),
    );
  }
}
