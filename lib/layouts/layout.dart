import 'package:cupboard/layouts/main_layout.dart';
import 'package:cupboard/layouts/main_web_layout.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class Layout extends StatelessWidget {
  final Widget child;
  final String title;
  final bool onlyBody;

  const Layout(this.child,
      {Key? key, required this.title, this.onlyBody = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? MainWebLayout(child, title: title, onlyBody: onlyBody)
        : MainLayout(child, title: title);
  }
}
