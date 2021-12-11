import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:login_screen_task/widgets/auth_form.dart';
import 'package:login_screen_task/widgets/background.dart';
import '../helper/customIntro.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool init = false;

  void _toggleLanguage() {
    setState(() {
      context.locale =
      context.locale == Locale('en', 'UK') ? Locale('ar', 'EG') : Locale(
          'en', 'UK');
    });
  }
    @override
    void initState() {
      super.initState();
      Timer(
        Duration(
          milliseconds: 500,
        ),
            () {
          /// start the intro
          intro.start(context);
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    print('width ${screenSize.width}');
    print('height ${screenSize.height}');
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImageWithGradient(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: (screenSize.height / 13.0).ceilToDouble(),
                      left: (screenSize.height / 16.0).ceilToDouble()),
                  child: LanguageButton(
                      _toggleLanguage,
                      intro.keys[0]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Image.asset(
                        'logo'.tr().toString(),
                        // "assets/images/logo_en.png",
                        width: screenSize.width * 0.7,
                        // height: screenSize.height * 0.,
                      )),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.02, vertical: screenSize.height*0.01),
                  child: AuthForm(
                      phoneKey: intro.keys[1],
                      passwordKey: intro.keys[2],
                      submitKey: intro.keys[3],
                    changeModeKey: intro.keys[4],
                    forgetPasswordKey: intro.keys[5],
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
