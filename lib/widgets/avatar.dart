import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double size;
  final double borderRadius;
  const Avatar(this.url, {Key? key, this.size = 30, this.borderRadius = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageProvider image;
    if (url.isEmpty) {
      image = const AssetImage('assets/images/default_nor_avatar.png');
    } else if (url.startsWith('assets') || url.startsWith('images')) {
      image = AssetImage(url);
    } else if (url.startsWith('http://') || url.startsWith('https://')) {
      image = NetworkImage(url);
    } else {
      image = const AssetImage('images/default_nor_avatar.png');
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
