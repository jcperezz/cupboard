import 'package:cupboard/models/Status.dart';
import 'package:cupboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/constants/Theme.dart';

//widgets
import 'package:cupboard/widgets/card-small.dart';
import 'package:cupboard/widgets/navbar.dart';
import 'package:cupboard/widgets/drawer.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        transparent: true,
        title: "Home",
        searchBar: true,
        //categoryOne: "Beauty",
        //categoryTwo: "Fashion",
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: ArgonColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: ArgonDrawer(currentPage: "Home"),
      body: Stack(
        children: [
          buildBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                child: buildBody(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCard(context, Status.pending()),
            buildCard(context, Status.expired()),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCard(context, Status.closeToExpire()),
            buildCard(context, Status.avalaible()),
          ],
        ),
      ],
    );
  }

  Widget buildCard(BuildContext context, Status status) {
    return CardSmall(
        cta: "Ver artículos",
        title: status.title,
        image: AssetImage("assets/img/" + status.img),
        tap: () {
          Navigator.pushNamed(context, status.navigationName);
        });
  }

  Widget buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage("assets/img/register-bg.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}
