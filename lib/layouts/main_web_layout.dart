import 'package:flutter/material.dart';

import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/widgets/drawer.dart';

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
    final Labels labels = Labels.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: labels.getMessage(title)),
      body: _buildScaffoldBody(context),
      extendBody: true,
    );
  }

  Widget _buildFullBody(BuildContext context) {
    final Labels labels = Labels.of(context);

    return Scaffold(
/*         appBar: onlyBody
        ? null
        : Navbar(
            transparent: false,
            title: labels.getMessage(title),
            searchBar: true,
          ), */
      appBar: NavBar2(),
      extendBodyBehindAppBar: true,
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: labels.getMessage(title)),
      body: _buildScaffoldBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(),
      //extendBody: true,
    );
  }

  Widget _buildScaffoldBody(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        Center(
          child: SizedBox(
            width: 600,
            child: this.onlyBody
                ? Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: child,
                  )
                : child,
          ),
        ),
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

class NavBar2 extends StatelessWidget implements PreferredSizeWidget {
  final double _prefferedHeight = AppBar().preferredSize.height * 0.75;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      //title: _buildTitle(context),
/*       leading: IconButton(
        icon: const Icon(Icons.search_outlined),
        onPressed: () {
          // handle the press
        },
      ), */
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.logout_outlined),
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
/*         style: GoogleFonts.ptSans(
            fontSize: 15, color: Theme.of(context).textTheme.headline1!.color), */
        children: <TextSpan>[
          TextSpan(
              text: 'Google ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Noticias'),
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
