import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shirne_dialog/shirne_dialog.dart';
import 'package:wechat_simulator/service/store.dart';
import 'package:wechat_simulator/theme.dart';
import 'home/home_screen.dart';
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
        theme: lightTheme(),
        darkTheme: darkTheme(),
        scrollBehavior: _AppScrollBehavior(),
        home: const HomeScreen(),
      ),
    );
  }

  ThemeData lightTheme() {
    const colorsScheme = ColorScheme.light(
      primary: Color(0xff46c11b),
      background: Color(0xffebebeb),
      onBackground: Color(0xff353535),
      tertiary: Color(0xffff3e3e),
      onTertiary: Color(0xffffffff),
      primaryContainer: Color(0xffffffff),
      onPrimaryContainer: Color(0xffd8d8d8),
      secondaryContainer: Colors.white,
      onSecondaryContainer: Color(0xff9e9e9e),

      /// for appbar
      surfaceVariant: Color(0xfffafafa),
      onSurfaceVariant: Color(0xff353535),
    );
    return ThemeData.light().copyWith(
      colorScheme: colorsScheme,
      backgroundColor: colorsScheme.background,
      scaffoldBackgroundColor: colorsScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colorsScheme.surfaceVariant,
        foregroundColor: colorsScheme.onSurfaceVariant,
        titleTextStyle: TextStyle(color: colorsScheme.onSurfaceVariant),
        actionsIconTheme: IconThemeData(color: colorsScheme.onSurfaceVariant),
        toolbarTextStyle: TextStyle(color: colorsScheme.onSurfaceVariant),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 16.0,
          color: colorsScheme.onBackground,
          fontWeight: FontWeight.w500,
        ),
        subtitle1: TextStyle(
          fontSize: 14.0,
          color: colorsScheme.onBackground,
        ),
        subtitle2: TextStyle(
          fontSize: 12.0,
          color: colorsScheme.onBackground,
        ),
        bodyText1: TextStyle(
          fontSize: 14.0,
          color: colorsScheme.onBackground,
        ),
        bodyText2: TextStyle(
          fontSize: 12.0,
          color: colorsScheme.onBackground,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          color: colorsScheme.onSecondaryContainer,
        ),
      ),
      extensions: [const AppTheme(), const ShirneDialogTheme()],
    );
  }

  ThemeData darkTheme() {
    const colorsScheme = ColorScheme.dark(
      primary: Color(0xff46c11b),
      background: Color(0xffebebeb),
      onBackground: Color(0xff353535),
      tertiary: Color(0xffff3e3e),
      onTertiary: Color(0xffffffff),
      primaryContainer: Color(0xffffffff),
      onPrimaryContainer: Color(0xffd8d8d8),

      /// for appbar
      surfaceVariant: Color(0xfffafafa),
      onSurfaceVariant: Color(0xff353535),
    );
    return ThemeData.dark().copyWith(
      colorScheme: colorsScheme,
      backgroundColor: colorsScheme.background,
      scaffoldBackgroundColor: colorsScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colorsScheme.surfaceVariant,
        foregroundColor: colorsScheme.onSurfaceVariant,
        titleTextStyle: TextStyle(color: colorsScheme.onSurfaceVariant),
        actionsIconTheme: IconThemeData(color: colorsScheme.onSurfaceVariant),
        toolbarTextStyle: TextStyle(color: colorsScheme.onSurfaceVariant),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 16.0,
          color: colorsScheme.onBackground,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          fontSize: 14.0,
          color: colorsScheme.onBackground,
        ),
        titleSmall: TextStyle(
          fontSize: 12.0,
          color: colorsScheme.onBackground,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          color: colorsScheme.onSecondaryContainer,
        ),
      ),
      extensions: [const AppTheme(), const ShirneDialogTheme()],
    );
  }
}

class _AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
      };
}
