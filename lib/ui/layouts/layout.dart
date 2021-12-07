import 'package:cupboard/ui/layouts/main_mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:cupboard/ui/layouts/main_web_layout.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final String title;
  final bool showNavBar;
  final bool showFooterBar;
  final String? cupboardUid;

  const Layout(
    this.child, {
    Key? key,
    required this.title,
    this.showNavBar = false,
    this.showFooterBar = false,
    this.cupboardUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? MainWebLayout(
            child,
            title: title,
            showNavBar: showNavBar,
            showFooterBar: showFooterBar,
            cupboardUid: cupboardUid,
          )
        : MainMobileLayout(
            child,
            title: title,
            showNavBar: showNavBar,
            showFooterBar: showFooterBar,
            cupboardUid: cupboardUid,
          );
  }
}
