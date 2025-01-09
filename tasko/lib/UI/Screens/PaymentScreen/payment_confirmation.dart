import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasko/UI/Screens/home/dashboard_screen.dart';

import '../../Themes/styles.dart';

class PaymentConfirmationPage extends StatelessWidget {
  const PaymentConfirmationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                            interestList: [
                              'Cricket',
                              'Football',
                              'Badminton',
                              'Skating',
                              'Yoga'
                            ],
                          )));
            },
            child: const Icon(Icons.close)),
        title: Text(
          'Payment Confirmation',
          style: paymentconfirmation,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Paymentpage/success_icon.png'),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Payment Successful',
              style: paymentconfirmation,
            ),
          ],
        ),
      ),
    );
  }
}
