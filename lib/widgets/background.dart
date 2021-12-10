import 'package:flutter/material.dart';

class BackgroundImageWithGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg_1_flipped.png',
          fit: BoxFit.fitHeight,
          height: height,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.4 , 0.65 , 0.9] ,
                colors: [
                  // Colors.deepPurpleAccent.withOpacity(0.7),
                  // Colors.deepPurple.withOpacity(0.2),
                  // Colors.deepPurple.withOpacity(0.1),
                  Color.fromRGBO(35,21,84, 0.97),
                  Color.fromRGBO(35,21,84, 0.45),
                  Color.fromRGBO(35,21,84, 0.43),
                ]),
          ),
        ),
      ],
    );
  }
}
