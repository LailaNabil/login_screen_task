// import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:login_screen_task/widgets/custom_card.dart';

class ProfileScreen extends StatelessWidget {

  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              // 'logo'.tr().toString(),
              "assets/images/logo_en.png",
              height: 50,
            ),
            Text('Profile')
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
              color: Theme.of(context).primaryColor.withOpacity(0.97),
              width: double.infinity,
              height: 150,
              alignment: AlignmentDirectional.center,
              child: Text(
                '0.00 LE',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.3,
                    crossAxisCount: 2),
                children: [
                  CustomCard(text:'Add a branch' , image: 'assets/images/icons/add_branch.png',),
                  CustomCard(text:'Management Control' , image: 'assets/images/icons/management_control.png',),
                  CustomCard(text:'Payment' , image: 'assets/images/icons/payment.png',),
                  CustomCard(text:'Notifications' , image: 'assets/images/icons/notification.png',),
                  CustomCard(text:'Settings' , image: 'assets/images/icons/settings.png',),
                  CustomCard(text:'Promotions' , image: 'assets/images/icons/promotions.png',),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
