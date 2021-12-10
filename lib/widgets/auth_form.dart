import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Key phoneKey;
  final Key passwordKey;
  final Key loginKey;

  LoginForm({this.passwordKey, this.phoneKey, this.loginKey,});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool passwordObscure;
  final auth = FirebaseAuth.instance;
  bool _isLogin;


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
    _isLogin = false;
    super.initState();
  }

  void _togglePasswordObscure() {
    setState(() {
      passwordObscure = !passwordObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
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
          padding: const EdgeInsets.only(top: 12.0),
          child: Center(
            child: SubmitButton(key: widget.loginKey, onPressed: _submit,),
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: screenSize.height*0.01, left: screenSize.width * 0.08, right: screenSize.width * 0.08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ChangeModeButton(intro.keys[4]),
              ChangeModeButton(),
              // ForgotPasswordButton(intro.keys[5]),
              ForgotPasswordButton(),
            ],
          ),
        )
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
    return Container(
      height: 55,
      child: FittedBox(
        fit: BoxFit.contain,
        child: ElevatedButton.icon(
          // key: key,
          onPressed: toggleLanguage,
          icon: Icon(
            Icons.language,
            // size: 22,
          ),
          label: Text(
            "EN",
            // 'lang'.tr().toString(),
            // maxFontSize: 22,
          ),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2)),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final Key key;
  final Function onPressed;

  SubmitButton({this.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        height: 22,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "Login",
            // 'login'.tr().toString(),
            // key: key,
            // style: TextStyle(fontSize: 20),
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
  // final Key key;
  //
  // ForgotPasswordButton(this.key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // key: key,
      onPressed: () {},
      child: Container(
        height: 20,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            'forgot password',
            // 'forgot_password'.tr().toString(),
            // key: key,
            style: TextStyle(
              // fontSize: 18,
                color: Colors.white70),
          ),
        ),
      ),
    );
  }
}

class ChangeModeButton extends StatelessWidget {
  // final Key key;
  //
  // ChangeModeButton(this.key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
        height: 22,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "sign up",
            // 'sign_up'.tr().toString(),
            style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor),
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
