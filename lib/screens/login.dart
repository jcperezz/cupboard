import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cupboard/constants/Theme.dart';

//widgets
import 'package:cupboard/widgets/input.dart';
import 'package:cupboard/widgets/navbar.dart';

class LoginScreen extends StatelessWidget {
  final double height = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          transparent: true,
          title: "",
          leftOptions: false,
          rightOptions: false,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [buildBackground(), buildSafeArea(context)],
        ));
  }

  Widget buildSafeArea(BuildContext context) {
    return SafeArea(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 16, left: 24.0, right: 24.0, bottom: 32),
          child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                children: [
                  buildPageTitle(context),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.63,
                      color: Color.fromRGBO(244, 245, 247, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildFormLegend(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildNameInput(),
                                  _buildEmailInput(),
                                  _buildPasswordInput(),
                                  _buildPasswordLegend(),
                                ],
                              ),
                              _buildCheckPolicy(context),
                              _buildSubmitButton(context)
                            ],
                          ),
                        ),
                      ))
                ],
              )),
        ),
      ]),
    );
  }

  Padding _buildFormLegend() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
      child: Center(
        child: Text("Or sign up with the classic way",
            style: TextStyle(
                color: ArgonColors.text,
                fontWeight: FontWeight.w200,
                fontSize: 16)),
      ),
    );
  }

  Padding _buildNameInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Input(
        placeholder: "Name",
        prefixIcon: Icon(Icons.school),
      ),
    );
  }

  Padding _buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Input(placeholder: "Email", prefixIcon: Icon(Icons.email)),
    );
  }

  Padding _buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Input(placeholder: "Password", prefixIcon: Icon(Icons.lock)),
    );
  }

  Padding _buildPasswordLegend() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: RichText(
          text: TextSpan(
              text: "password strength: ",
              style: TextStyle(color: ArgonColors.muted),
              children: [
            TextSpan(
                text: "strong",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: ArgonColors.success))
          ])),
    );
  }

  Padding _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: FlatButton(
          textColor: ArgonColors.white,
          color: ArgonColors.primary,
          onPressed: () {
            // Respond to button press
            Navigator.pushNamed(context, '/home');
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
              padding:
                  EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12),
              child: Text("REGISTER",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0))),
        ),
      ),
    );
  }

  Padding _buildCheckPolicy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 0, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              activeColor: ArgonColors.primary,
              onChanged: (bool? newValue) {},
              value: false),
          Text("I agree with the",
              style: TextStyle(
                  color: ArgonColors.muted, fontWeight: FontWeight.w200)),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/pro');
              },
              child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text("Privacy Policy",
                    style: TextStyle(color: ArgonColors.primary)),
              )),
        ],
      ),
    );
  }

  Container buildBackground() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/register-bg.png"),
              fit: BoxFit.cover)),
    );
  }

  Container buildPageTitle(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            color: ArgonColors.white,
            border: Border(
                bottom: BorderSide(width: 0.5, color: ArgonColors.muted))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Sign in with",
                  style: TextStyle(color: ArgonColors.text, fontSize: 16.0)),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // width: 0,
                    height: 36,
                    child: RaisedButton(
                        textColor: ArgonColors.primary,
                        color: ArgonColors.secondary,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 10, top: 10, left: 14, right: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(FontAwesomeIcons.github, size: 13),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("GITHUB",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13))
                              ],
                            ))),
                  ),
                  Container(
                    // width: 0,
                    height: 36,
                    child: RaisedButton(
                        textColor: ArgonColors.primary,
                        color: ArgonColors.secondary,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 10, top: 10, left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(FontAwesomeIcons.facebook, size: 13),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("FACEBOOK",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13))
                              ],
                            ))),
                  ),
                ],
              ),
            ),
            // Divider()
          ],
        ));
  }
}
