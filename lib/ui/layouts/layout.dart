import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:cupboard/ui/layouts/main_layout.dart';
import 'package:cupboard/ui/layouts/main_web_layout.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final String title;
  final bool showNavBar;
  final bool showFooterBar;

  const Layout(this.child,
      {Key? key,
      required this.title,
      this.showNavBar = false,
      this.showFooterBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? MainWebLayout(
            child,
            title: title,
            showNavBar: showNavBar,
            showFooterBar: showFooterBar,
          )
        : MainLayout(child, title: title);
  }
}
