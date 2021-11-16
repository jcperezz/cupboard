import 'package:flutter/material.dart';

import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/widgets/drawer.dart';
import 'package:cupboard/widgets/navbar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const MainLayout(this.child, {required this.title});

  @override
  Widget build(BuildContext context) {
    final Labels labels = Labels.of(context);

    return Scaffold(
      appBar: Navbar(
        transparent: true,
        //title: labels.getMessage(title),
        searchBar: true,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: ArgonColors.bgColorScreen,
      drawer:
          ArgonDrawer(currentPage: labels.getMessage("cupboard_page_title")),
      body: _buildScaffoldBody(context),
    );
  }

  Stack _buildScaffoldBody(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        _wrapBody(),
      ],
    );
  }

  ListView _wrapBody() {
    return ListView(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: child,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage("assets/img/register-bg.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}
