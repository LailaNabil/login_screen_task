// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class AuthForm extends StatefulWidget {
//   final Key emailKey;
//   final Key phoneKey;
//   final Key passwordKey;
//   final Key loginKey;
//
//   AuthForm({
//     this.emailKey,
//     this.passwordKey,
//     this.phoneKey,
//     this.loginKey,
//   });
//
//   @override
//   _AuthFormState createState() => _AuthFormState();
// }
//
// class _AuthFormState extends State<AuthForm> {
//   bool passwordObscure;
//   final auth = FirebaseAuth.instance;
//   bool _isLogin;
//   String verificationId;
//
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   _onVerificationCompleted(PhoneAuthCredential authCredential) async {
//     print("verification completed ${authCredential.smsCode}");
//     final user = FirebaseAuth.instance.currentUser;
//     setState(() {
//       // this.otpController.text = authCredential.smsCode;
//     });
//     // if (authCredential.smsCode != null) {
//     if (true) {
//       try{
//         UserCredential credential =
//         await user.linkWithCredential(authCredential);
//       }on FirebaseAuthException catch(e){
//         if(e.code == 'provider-already-linked'){
//           await auth.signInWithCredential(authCredential);
//         }
//       }
//     }
//   }
//
//   _onVerificationFailed(FirebaseAuthException exception) {
//     if (exception.code == 'invalid-phone-number') {
//       showMessage("The phone number entered is invalid!");
//     }
//   }
//
//   _onCodeSent(String verificationId, int forceResendingToken) {
//     this.verificationId = verificationId;
//     print(forceResendingToken);
//     print("code sent");
//   }
//
//   _onCodeTimeout(String timeout) {
//     return null;
//   }
//
//   void showMessage(String errorMessage) {
//     showDialog(
//         context: context,
//         builder: (BuildContext builderContext) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text(errorMessage),
//             actions: [
//               TextButton(
//                 child: Text("Ok"),
//                 onPressed: () async {
//                   Navigator.of(builderContext).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }
//
//   void _submit() async {
//     if (
//         passwordController.text.length >= 9) {
//       // final email = '${phoneController.text}@test.com';
//       final email = emailController.text;
//       final password = passwordController.text;
//       final phone = phoneController.text;
//       print('email $email');
//       print('password $password');
//       print('submit');
//       //using a hack to use phone number as an email
//       if(_isLogin){
//         await auth.signInWithEmailAndPassword(email: email, password: password);
//         print('login done? ${auth.currentUser}');
//       }else{
//         final user = await auth.createUserWithEmailAndPassword(email: email, password: password);
//         // await auth.verifyPhoneNumber(
//         //     phoneNumber: phone,
//         //     verificationCompleted: _onVerificationCompleted,
//         //     verificationFailed: _onVerificationFailed,
//         //     codeSent: _onCodeSent,
//         //     codeAutoRetrievalTimeout: _onCodeTimeout);
//         print('user $user}');
//         print('sign up done? ${auth.currentUser}');
//       }
//     }
//
//
//     // await auth.verifyPhoneNumber(
//     //   phoneNumber: '+151018087756',
//     //   verificationCompleted: (PhoneAuthCredential credential) {
//     //     print('verificationCompleted');
//     //   },
//     //   verificationFailed: (FirebaseAuthException e) {
//     //     print('verificationFailed');
//     //   },
//     //   codeSent: (String verificationId, int resendToken) async {
//     //     // Update the UI - wait for the user to enter the SMS code
//     //     // String smsCode = '101513';
//     //     String smsCode = '123321';
//     //
//     //     // Create a PhoneAuthCredential with the code
//     //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//     //         verificationId: verificationId, smsCode: smsCode);
//     //     print('credential $credential');
//     //     // // Sign the user in (or link) with the credential
//     //     // await widget.auth.signInWithCredential(credential);
//     //   },
//     //   codeAutoRetrievalTimeout: (String verificationId) {},
//     // );
//
//   }
//
//   @override
//   void initState() {
//     passwordObscure = true;
//     _isLogin = false;
//     super.initState();
//   }
//
//   void _togglePasswordObscure() {
//     setState(() {
//       passwordObscure = !passwordObscure;
//     });
//   }
//
//   void _changeMode() {
//     setState(() {
//       _isLogin = !_isLogin;
//     });
//     print('mode now is $_isLogin Login');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         if(!_isLogin)
//           TextField(
//           key: widget.emailKey,
//           controller: emailController,
//           style: TextStyle(color: Colors.white, fontSize: 22),
//           keyboardType: TextInputType.emailAddress,
//           decoration: InputDecoration(
//               labelText: "Enter Email",
//               // 'auth_phone'.tr().toString(),
//               labelStyle: TextStyle(color: Colors.white70, fontSize: 15)),
//         ),
//         TextField(
//           key: widget.phoneKey,
//           controller: phoneController,
//           onEditingComplete: () async {
//             await auth.verifyPhoneNumber(
//                 // phoneNumber: phoneController.text,
//               phoneNumber: '+201018087756',
//                 verificationCompleted: _onVerificationCompleted,
//                 verificationFailed: _onVerificationFailed,
//                 codeSent: _onCodeSent,
//                 codeAutoRetrievalTimeout: _onCodeTimeout);
//           },
//           style: TextStyle(color: Colors.white, fontSize: 22),
//           keyboardType: TextInputType.phone,
//           decoration: InputDecoration(
//               labelText: "Enter Phone Number",
//               // 'auth_phone'.tr().toString(),
//               labelStyle: TextStyle(color: Colors.white70, fontSize: 15)),
//         ),
//         if(!_isLogin)
//           TextField(
//             // key: widget.phoneKey,
//             controller: otpController,
//             style: TextStyle(color: Colors.white, fontSize: 22),
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//                 labelText: "Enter OTP",
//                 // 'auth_phone'.tr().toString(),
//                 labelStyle: TextStyle(color: Colors.white70, fontSize: 15)),
//           ),
//         Row(
//           // alignment: Alignment.centerRight,
//           children: [
//             Expanded(
//               child: TextField(
//                 key: widget.passwordKey,
//                 controller: passwordController,
//                 style: TextStyle(color: Colors.white, fontSize: 22),
//                 obscureText: passwordObscure,
//                 decoration: InputDecoration(
//                     labelText: "Enter Password",
//                     // 'auth_password'.tr().toString(),
//                     labelStyle: TextStyle(color: Colors.white70, fontSize: 15)),
//               ),
//             ),
//             IconButton(
//               onPressed: _togglePasswordObscure,
//               icon: Icon(
//                   passwordObscure ? Icons.visibility : Icons.visibility_off),
//               color: Colors.white,
//             )
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 12.0),
//           child: Center(
//             child: SubmitButton(
//               key: widget.loginKey,
//               onPressed: _submit,
//               isLogin: _isLogin,
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//               top: screenSize.height * 0.01,
//               left: screenSize.width * 0.08,
//               right: screenSize.width * 0.08),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // ChangeModeButton(intro.keys[4]),
//               ChangeModeButton(isLogin: _isLogin,onPressed: _changeMode,),
//               // ForgotPasswordButton(intro.keys[5]),
//               ForgotPasswordButton(),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class LanguageButton extends StatelessWidget {
//   final Function toggleLanguage;
//
//   // final Key key;
//
//   LanguageButton(
//     this.toggleLanguage,
//     // this.key
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 55,
//       child: FittedBox(
//         fit: BoxFit.contain,
//         child: ElevatedButton.icon(
//           // key: key,
//           onPressed: toggleLanguage,
//           icon: Icon(
//             Icons.language,
//             // size: 22,
//           ),
//           label: Text(
//             "EN",
//             // 'lang'.tr().toString(),
//             // maxFontSize: 22,
//           ),
//           style: ButtonStyle(
//               padding: MaterialStateProperty.all(
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 2)),
//               shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14))),
//               backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
//         ),
//       ),
//     );
//   }
// }
//
// class SubmitButton extends StatelessWidget {
//   final Key key;
//   final Function onPressed;
//   final bool isLogin;
//
//   SubmitButton({this.key, this.onPressed, this.isLogin});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Container(
//         height: 22,
//         child: FittedBox(
//           fit: BoxFit.contain,
//           child: Text(
//             isLogin ? "Login" : "Sign up",
//             // 'login'.tr().toString(),
//             // key: key,
//             // style: TextStyle(fontSize: 15),
//           ),
//         ),
//       ),
//       style: ButtonStyle(
//           padding: MaterialStateProperty.all(
//               EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
//           shape: MaterialStateProperty.all(
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//           backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
//     );
//   }
// }
//
// class ForgotPasswordButton extends StatelessWidget {
//   // final Key key;
//   //
//   // ForgotPasswordButton(this.key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       // key: key,
//       onPressed: () {},
//       child: Container(
//         height: 15,
//         child: FittedBox(
//           fit: BoxFit.contain,
//           child: Text(
//             'forgot password',
//             // 'forgot_password'.tr().toString(),
//             // key: key,
//             style: TextStyle(
//                 // fontSize: 18,
//                 color: Colors.white70),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChangeModeButton extends StatelessWidget {
//   final bool isLogin;
//   final Function onPressed;
//
//   // final Key key;
//   //
//   ChangeModeButton(
//       {this.isLogin,
//       // this.key
//       this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Container(
//         height: 22,
//         child: FittedBox(
//           fit: BoxFit.contain,
//           child: Text(
//             isLogin ?  "Sign up" : "Login",
//             // 'sign_up'.tr().toString(),
//             style: TextStyle(color: Theme.of(context).primaryColor),
//           ),
//         ),
//       ),
//       style: ButtonStyle(
//           padding: MaterialStateProperty.all(
//               EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
//           shape: MaterialStateProperty.all(
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//           backgroundColor: MaterialStateProperty.all(Colors.white)),
//     );
//   }
// }
