import 'package:cupboard/domain/notifiers/authentication_notifier.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/widgets/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainWebLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final bool onlyBody;

  const MainWebLayout(this.child, {required this.title, this.onlyBody = false});

  @override
  Widget build(BuildContext context) {
    return this.onlyBody ? _buildOnlyBody(context) : _buildFullBody(context);
  }

  Widget _buildOnlyBody(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ArgonColors.bgColorScreen,
      body: _buildScaffoldBody(context),
      extendBody: true,
    );
  }

  Widget _buildFullBody(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ArgonColors.bgColorScreen,
      body: _buildScaffoldBody(context),
    );
  }

  Widget _buildScaffoldBody(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 600,
            child: this.onlyBody ? _wrapChildren() : _wrapScafold(context),
          ),
        ]),
      ],
    );
  }

  Widget _wrapScafold(BuildContext context) {
    final Labels labels = Labels.of(context);
    return Scaffold(
      appBar: NavBar2(title: labels.getMessage(title)),
      backgroundColor: Colors.transparent,
      extendBody: true,
      //drawer: ArgonDrawer(currentPage: labels.getMessage(title)),
      body: child,
/*       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, */
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _wrapChildren() => Padding(
        padding: EdgeInsets.only(top: 100),
        child: child,
      );

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

class NavBar2 extends StatelessWidget implements PreferredSizeWidget {
  final double _prefferedHeight = AppBar().preferredSize.height * 0.75;

  final String title;

  NavBar2({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationNotifier service =
        Provider.of<AuthenticationNotifier>(context, listen: false);

    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: _buildTitle(context),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed: () {
            service.signOut();
            Navigator.of(context).pushNamed("/");
          },
        )
      ],
    );
  }

/*   Widget buildAvatar() {
    //"https://www.w3schools.com/w3images/avatar6.png"
    return CacheNetImage(
      url: "https://www.w3schools.com/w3images/avatar6.png",
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
      ),
    );
  } */

  Widget _buildTitle(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.ptSans(
            fontSize: 25, color: Theme.of(context).textTheme.headline1!.color),
        children: <TextSpan>[
          TextSpan(
              text: title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.black,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {},
          ),
          SizedBox(
            width: 40,
          ),
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            color: Colors.black,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_box),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
