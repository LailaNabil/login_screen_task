// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_intro/flutter_intro.dart';

import 'package:flutter/material.dart';
import 'package:login_screen_task/widgets/auth_form.dart';
import 'package:login_screen_task/widgets/background.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool init = false;


  void _toggleLanguage() {
    // setState(() {
    //   context.locale =
    //   context.locale == Locale('en', 'UK') ? Locale('ar', 'EG') : Locale(
    //       'en', 'UK');
    // });
  }

  // Intro intro = Intro(
  //
  //   /// You can set it true to disable animation
  //   noAnimation: false,
  //
  //   /// The total number of guide pages, must be passed
  //   stepCount: 6,
  //
  //   /// Click on whether the mask is allowed to be closed.
  //   maskClosable: true,
  //
  //   /// When highlight widget is tapped.
  //   onHighlightWidgetTap: (introStatus) {
  //     print(introStatus);
  //   },
  //
  //   /// The padding of the highlighted area and the widget
  //   padding: EdgeInsets.all(8),
  //
  //   /// Border radius of the highlighted area
  //   borderRadius: BorderRadius.all(Radius.circular(4)),
  //
  //   /// Use the default useDefaultTheme provided by the library to quickly build a guide page
  //   /// Need to customize the style and content of the guide page, implement the widgetBuilder method yourself
  //   /// * Above version 2.3.0, you can use useAdvancedTheme to have more control over the style of the widget
  //   /// * Please see https://github.com/tal-tech/flutter_intro/issues/26
  //   widgetBuilder: StepWidgetBuilder.useDefaultTheme(
  //
  //     /// Guide page text
  //     texts: [
  //       'Change Language from here',
  //       'Enter phone number to login here',
  //       'Enter password to login/sign up here',
  //       'After entering phone number and password,press login',
  //       'To switch to sign up mode,press here',
  //       'In case you forgot your password,press here',
  //     ],
  //
  //     /// Button text
  //     buttonTextBuilder: (curr, total) {
  //       return curr < total - 1 ? 'Next' : 'Finish';
  //     },
  //   ),
  // );


  // @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //     Duration(
  //       milliseconds: 500,
  //     ),
  //         () {
  //       /// start the intro
  //       intro.start(context);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // intro.start(context);
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
                      // intro.keys[0]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Image.asset(
                        // 'logo'.tr().toString(),
                        "assets/images/logo_en.png",
                        width: screenSize.width * 0.8,
                      )),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.02, vertical: screenSize.height*0.01),
                  child: LoginForm(
                      // phoneKey: intro.keys[1],
                      // passwordKey: intro.keys[2],
                      // loginKey: intro.keys[3]
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(top: screenSize.height*0.01, left: screenSize.width * 0.08, right: screenSize.width * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SignupButton(intro.keys[4]),
                      SignupButton(),
                      // ForgotPasswordButton(intro.keys[5]),
                      ForgotPasswordButton(),
                    ],
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
