import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double size;
  const Avatar(this.url, {Key? key, this.size = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Image.asset(
        'assets/images/default_nor_avatar.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }
    if (url.startsWith('assets') || url.startsWith('images')) {
      return Image.asset(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      'images/default_nor_avatar.png',
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}
