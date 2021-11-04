import 'package:cupboard/services/navigation_service.dart';
import 'package:cupboard/widgets/drawer-tile.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/constants/Theme.dart';
import 'package:provider/provider.dart';

class ArgonDrawer extends StatelessWidget {
  final String? currentPage;

  ArgonDrawer({this.currentPage});

  _launchURL() async {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.white,
      child: Column(children: [
        buildLogo(context),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushNamed(context, "/home");
                  },
                  iconColor: ArgonColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    print("funciona");
                    if (currentPage != "Profile")
                      Navigator.pushNamed(context, "/register");
                  },
                  iconColor: ArgonColors.warning,
                  title: "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "Account")
                      Navigator.pushNamed(context, "/register");
                  },
                  iconColor: ArgonColors.info,
                  title: "Account",
                  isSelected: currentPage == "Account" ? true : false),
              Divider(height: 4, thickness: 0, color: ArgonColors.muted),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                child: Text("ADMINISTRACION",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 15,
                    )),
              ),
              DrawerTile(
                  icon: Icons.category,
                  onTap: () {
                    print("funciona");
                    if (currentPage != "Categories")
                      Navigator.pushNamed(context, "/categories");
                  },
                  iconColor: ArgonColors.info,
                  title: "Categorías",
                  isSelected: currentPage == "Categories" ? true : false),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.airplanemode_active,
                      onTap: _launchURL,
                      iconColor: ArgonColors.muted,
                      title: "Getting Started",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }

  Container buildLogo(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.85,
        child: SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Image.asset("assets/img/cupboard-logo.png"),
            ),
          ),
        ));
  }
}
