import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shirne_dialog/shirne_dialog.dart';
import 'package:wechat_simulator/service/store.dart';
import 'home/home_screen.dart';
import 'constants.dart' show AppColors;
import 'model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await StoreService().init();
  final user = StoreService.instance.fetchToken();
  runApp(MainApp(user: user ?? User(nickname: '', account: '')));
}

class MainApp extends StatelessWidget {
  final User user;
  const MainApp({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Provider<User>(
      create: (BuildContext context) => user,
      child: MaterialApp(
        title: '微信',
        navigatorKey: MyDialog.navigatorKey,
        localizationsDelegates: const [
          ShirneDialogLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.appBarColor,
            foregroundColor: AppColors.titleColor,
            titleTextStyle: TextStyle(color: AppColors.titleColor),
            actionsIconTheme: IconThemeData(color: AppColors.titleColor),
            toolbarTextStyle: TextStyle(color: AppColors.titleColor),
          ),
          extensions: [const ShirneDialogTheme()],
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
