import 'package:cupboard/services/authentication_service.dart';
import 'package:cupboard/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:cupboard/constants/Theme.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final bool leftOptions;
  final Function? getCurrentPage;
  final bool isOnSearch;
  final TextEditingController? searchController;
  final Function? searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  Navbar(
      {this.title = "Home",
      this.transparent = false,
      this.rightOptions = true,
      this.leftOptions = true,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = ArgonColors.white,
      this.searchBar = false});

  final double _prefferedHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  ItemScrollController _scrollController = ItemScrollController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);

    return Container(
        height: 110,
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? ArgonColors.initial
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.leftOptions)
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                  !widget.backButton
                                      ? Icons.menu
                                      : Icons.arrow_back_ios,
                                  color: !widget.transparent
                                      ? (widget.bgColor == ArgonColors.white
                                          ? ArgonColors.initial
                                          : ArgonColors.white)
                                      : ArgonColors.white,
                                  size: 24.0),
                              onPressed: () {
                                if (!widget.backButton)
                                  Scaffold.of(context).openDrawer();
                                else
                                  Navigator.pop(context);
                              }),
                          Text(widget.title,
                              style: TextStyle(
                                  color: !widget.transparent
                                      ? (widget.bgColor == ArgonColors.white
                                          ? ArgonColors.initial
                                          : ArgonColors.white)
                                      : ArgonColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0)),
                        ],
                      ),
                    if (widget.rightOptions)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/pro');
                            },
                            child: IconButton(
                                icon: Icon(Icons.notifications_active,
                                    color: !widget.transparent
                                        ? (widget.bgColor == ArgonColors.white
                                            ? ArgonColors.initial
                                            : ArgonColors.white)
                                        : ArgonColors.white,
                                    size: 22.0),
                                onPressed: null),
                          ),
                          GestureDetector(
                            onTap: () {
                              authService.signOut();
                            },
                            child: IconButton(
                                icon: Icon(Icons.logout,
                                    color: !widget.transparent
                                        ? (widget.bgColor == ArgonColors.white
                                            ? ArgonColors.initial
                                            : ArgonColors.white)
                                        : ArgonColors.white,
                                    size: 22.0),
                                onPressed: null),
                          ),
                        ],
                      )
                  ],
                ),
                if (widget.searchBar)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 4, left: 15, right: 15),
                    child: Input(
                        placeholder: "What are you looking for?",
                        controller: widget.searchController,
                        onChanged: (String arg) => widget.searchOnChanged,
                        autofocus: widget.searchAutofocus,
                        suffixIcon:
                            Icon(Icons.zoom_in, color: ArgonColors.muted),
                        onTap: () {
                          Navigator.pushNamed(context, '/pro');
                        }),
                  ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ));
  }
}
