import 'dart:ui';
import 'package:cupboard/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/constants/validators.dart';

import 'package:cupboard/services/authentication_service.dart';
//widgets
import 'package:cupboard/widgets/navbar.dart';
import 'package:cupboard/widgets/form-input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double height = window.physicalSize.height;
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _secret = "";

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
          children: [
            _buildBackground(),
            buildSafeArea(context),
          ],
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
                borderRadius: BorderRadius.circular(ArgonColors.shape_radius),
              ),
              child: Column(
                children: [
                  _buildPageTitle(context),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
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
                                    _buildEmailInput(),
                                    _buildPasswordInput(),
                                  ],
                                ),
                                SizedBox(height: 100),
                                _buildSubmitButton(context)
                              ],
                            ),
                          ),
                        )),
                  )
                ],
              )),
        ),
      ]),
    );
  }

  Widget _buildFormLegend() {
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

  Widget _buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormInput(
        onChanged: (value) => setState(() => _email = value),
        placeholder: "Email",
        prefixIcon: Icon(Icons.email),
        validator: (value) => Validator<String>(value)
            .mandatory(message: "mi mamá me mima")
            .length(min: 5, max: 64)
            .isEmail()
            .validate(),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormInput(
        onChanged: (value) => setState(() => _secret = value),
        obscureText: true,
        placeholder: "Password",
        prefixIcon: Icon(Icons.lock),
        validator: (value) => Validator<String>(value)
            .mandatory(message: "mi mamá me mima")
            .length(min: 5, max: 64)
            .validate(),
      ),
    );
  }

  Padding _buildSubmitButton(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ArgonColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ArgonColors.shape_radius)),
          ),
          onPressed: () {
            print("tales $_email $_secret");

            if (_formKey.currentState!.validate()) {
              authService.signIn(_email, _secret);
            }
          },
          child: Padding(
              padding:
                  EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12),
              child: Text("SIGN IN",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0))),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/register-bg.png"),
              fit: BoxFit.cover)),
    );
  }

  Widget _buildPageTitle(BuildContext context) {
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
          ],
        ));
  }
}
