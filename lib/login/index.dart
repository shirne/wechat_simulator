import 'package:flutter/material.dart';

class LoginIndexPage extends StatefulWidget {
  const LoginIndexPage({Key? key}) : super(key: key);

  @override
  State<LoginIndexPage> createState() => _LoginIndexPageState();
}

class _LoginIndexPageState extends State<LoginIndexPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('登录'),
      ),
    );
  }
}
