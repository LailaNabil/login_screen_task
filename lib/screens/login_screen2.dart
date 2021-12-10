import 'dart:async';
import 'dart:convert';

// import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_intro/flutter_intro.dart';

import 'package:flutter/material.dart';
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
                  child: AuthForm(
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

class AuthForm extends StatefulWidget {
  final Key phoneKey;
  final Key passwordKey;
  final Key loginKey;

  AuthForm({this.passwordKey, this.phoneKey, this.loginKey,});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool passwordObscure;
  final auth = FirebaseAuth.instance;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void _submit() async{
    // if (phoneController.text.isNotEmpty &&
    //     passwordController.text.length == 6) {
    //   final response = FirebaseAuth.instance.signInWithPhoneNumber(
    //       verificationId: phoneController.text, smsCode: passwordController.text);
    // }
    print('submit');
    await auth.verifyPhoneNumber( phoneNumber: '+201018087756',
      verificationCompleted: (PhoneAuthCredential credential) {
      print('verificationCompleted');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verificationFailed');
      },
      codeSent: (String verificationId, int resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        // String smsCode = '102013';
        String smsCode = '123321';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        print('credential $credential');
        // // Sign the user in (or link) with the credential
        // await widget.auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},);
  }

  @override
  void initState() {
    passwordObscure = true;
    super.initState();
  }

  void _togglePasswordObscure() {
    setState(() {
      passwordObscure = !passwordObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: widget.phoneKey,
          controller: phoneController,
          style: TextStyle(color: Colors.white, fontSize: 25),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              labelText:
                  "Enter Phone Number",
              // 'auth_phone'.tr().toString(),
              labelStyle: TextStyle(color: Colors.white70, fontSize: 20)),
        ),
        Row(
          // alignment: Alignment.centerRight,
          children: [
            Expanded(
              child: TextField(
                key: widget.passwordKey,
                controller: passwordController,
                style: TextStyle(color: Colors.white, fontSize: 25),
                obscureText: passwordObscure,
                decoration: InputDecoration(
                    labelText:
                "Enter Password",
                    // 'auth_password'.tr().toString(),
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 20)),
              ),
            ),
            IconButton(
              onPressed: _togglePasswordObscure,
              icon: Icon(
                  passwordObscure ? Icons.visibility : Icons.visibility_off),
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: LoginButton(key: widget.loginKey, onPressed: _submit,),
          ),
        ),
      ],
    );
  }
}

class LanguageButton extends StatelessWidget {
  final Function toggleLanguage;
  // final Key key;

  LanguageButton(this.toggleLanguage,
      // this.key
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      // key: key,
      onPressed: toggleLanguage,
      icon: Icon(
        Icons.language,
        size: 20,
      ),
      label: AutoSizeText(
        "EN",
        // 'lang'.tr().toString(),
       maxFontSize: 20,
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Key key;
  final Function onPressed;

  LoginButton({this.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: AutoSizeText(
        "Login",
        // 'login'.tr().toString(),
        // key: key,
        maxFontSize: 18,
        minFontSize: 16,
        // style: TextStyle(fontSize: 20),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  // final Key key;
  //
  // ForgotPasswordButton(this.key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // key: key,
      onPressed: () {},
      child: AutoSizeText(
        'forgot password',
        // 'forgot_password'.tr().toString(),
        // key: key,
        maxFontSize: 16,
        minFontSize: 14,
        style: TextStyle(
            // fontSize: 18,
            color: Colors.white70),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  // final Key key;
  //
  // SignupButton(this.key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: AutoSizeText(
        "sign up",
        // 'sign_up'.tr().toString(),
        maxFontSize: 16,
        minFontSize: 14,
        style: TextStyle(
            // fontSize: 20,
            color: Theme
            .of(context)
            .primaryColor),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: MaterialStateProperty.all(Colors.white)),
    );
  }
}
