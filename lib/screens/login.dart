import 'dart:ui';
import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/widgets/button.dart';
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
        child: Text(Labels.of(context).getMessage("signin_subtitle"),
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
        placeholder: Labels.of(context).getMessage('email_label'),
        keyboardType: TextInputType.emailAddress,
        prefixIcon: Icon(Icons.email),
        validator: (value) => Validator<String>(value)
            .mandatory(msg: Labels.of(context).getMessage('email_mandatory'))
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
        keyboardType: TextInputType.text,
        placeholder: Labels.of(context).getMessage('password_label'),
        prefixIcon: Icon(Icons.lock),
        validator: (value) => Validator<String>(value)
            .mandatory(msg: Labels.of(context).getMessage('password_mandatory'))
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button.primary(
              keyMessage: "signin_submit",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  authService.signIn(context, _email, _secret);
                }
              },
            ),
            SizedBox(
              width: 10,
            ),
            Button.secondary(
              keyMessage: "signup_submit",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  authService.signIn(context, _email, _secret);
                }
              },
            ),
          ],
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
              child: Text(Labels.of(context).getMessage('signin_title'),
                  style: TextStyle(color: ArgonColors.text, fontSize: 16.0)),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
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
