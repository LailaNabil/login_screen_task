import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:login_screen_task/screens/profile_screen.dart';

class AuthForm extends StatefulWidget {
  final Key phoneKey;
  final Key passwordKey;
  final Key submitKey;
  final Key changeModeKey;
  final Key forgetPasswordKey;

  AuthForm({
    this.passwordKey,
    this.phoneKey,
    this.changeModeKey,
    this.submitKey,
    this.forgetPasswordKey
  });

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool passwordObscure;
  final auth = FirebaseAuth.instance;
  bool _isLogin;
  String verificationId;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        });
  }

  void _submit() async {
    if (phoneController.text.isNotEmpty &&
        passwordController.text.length >= 9) {
      final email = '${phoneController.text}@test.com';
      // final email = emailController.text;
      final password = passwordController.text;
      print('email $email');
      print('password $password');
      print('submit');
      //using a hack to use phone number as an email
      if (auth.currentUser != null) {
        Navigator.of(context).pushReplacementNamed(ProfileScreen.route);
      } else {
        try{
          if (_isLogin) {
            print('before login ${auth.currentUser}');
            await auth.signInWithEmailAndPassword(
                email: email, password: password);
            print('login done? ${auth.currentUser}');
          } else {
            final user = await auth.createUserWithEmailAndPassword(
                email: email, password: password);
            print('user $user}');
            print('sign up done? ${auth.currentUser}');
          }
          if (auth.currentUser != null) {
            Navigator.of(context).pushReplacementNamed(ProfileScreen.route);
          }
        }catch(error){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
        }

      }
    }
  }

  @override
  void initState() {
    passwordObscure = true;
    _isLogin = true;
    auth.signOut();
    super.initState();
  }

  void _togglePasswordObscure() {
    setState(() {
      passwordObscure = !passwordObscure;
    });
  }

  void _changeMode() {
    print('mode now is $_isLogin Login');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        TextField(
          key: widget.phoneKey,
          controller: phoneController,
          style: TextStyle(color: Colors.white, fontSize: 22),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              labelText:
              // "Enter Phone Number",
              'auth_phone'.tr().toString(),
              labelStyle: TextStyle(color: Colors.white70, fontSize: 15)),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                key: widget.passwordKey,
                controller: passwordController,
                style: TextStyle(color: Colors.white, fontSize: 22),
                obscureText: passwordObscure,
                decoration: InputDecoration(
                    labelText:
                    // "Enter Password",
                    'auth_password'.tr().toString(),
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 15)),
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
          padding: const EdgeInsets.only(top: 12.0),
          child: Center(
            child: SubmitButton(
              onPressed: _submit,
              isLogin: _isLogin,
              key: widget.submitKey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: screenSize.height * 0.01,
              left: screenSize.width * 0.08,
              right: screenSize.width * 0.08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChangeModeButton(
                key: widget.changeModeKey,
                isLogin: _isLogin,
                onPressed: _changeMode,
              ),
              ForgotPasswordButton(widget.forgetPasswordKey),
            ],
          ),
        )
      ],
    );
  }
}

class LanguageButton extends StatelessWidget {
  final Function toggleLanguage;

  final Key key;

  LanguageButton(
    this.toggleLanguage,
    this.key
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: FittedBox(
        fit: BoxFit.contain,
        child: ElevatedButton.icon(
          key: key,
          onPressed: toggleLanguage,
          icon: Icon(
            Icons.language,
            // size: 22,
          ),
          label: Text(
            // "EN",
            'lang'.tr().toString(),
            // maxFontSize: 22,
          ),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final Key key;
  final Function onPressed;
  final bool isLogin;

  SubmitButton({
    this.key,
    this.onPressed, this.isLogin});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      key: key,
      child: Container(
        height: 22,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            // isLogin ? "Login" : "Sign up",
              isLogin ? 'login'.tr().toString() : 'sign_up'.tr().toString(),
            // style: TextStyle(fontSize: 15),
          ),
        ),
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
  final Key key;

  ForgotPasswordButton(this.key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: key,
      onPressed: () {},
      child: Container(
        // height: 15,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            // 'forgot password',
            'forgot_password'.tr().toString(),
            style: TextStyle(
                fontSize: 14,
                color: Colors.white70),
          ),
        ),
      ),
    );
  }
}

class ChangeModeButton extends StatelessWidget {
  final bool isLogin;
  final Function onPressed;

  final Key key;
  ChangeModeButton(
      {this.isLogin,
      this.key,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      child: Container(
        height: 22,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            // isLogin ? "Sign up" : "Login",
            isLogin ? 'sign_up'.tr().toString() :  'login'.tr().toString(),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
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
