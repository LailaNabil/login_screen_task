import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final String image;

  CustomCard({this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      splashColor: Theme.of(context).primaryColorLight,
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image , width: 50,),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: AutoSizeText(
                text,
                maxLines: 1,
                maxFontSize: 16,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}