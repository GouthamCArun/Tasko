import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_upi_pay/flutter_upi_pay.dart';
import 'package:tasko/UI/Screens/PaymentScreen/payment_confirmation.dart';
import 'package:tasko/UI/Themes/colors.dart';
import '../../Themes/styles.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final program = {
    "name": "Yoga",
    "trainer": "Aswin",
    "Duration": "Daily / 2 Months",
    "location": " Kakkanad",
    "startingdate": "12th July 2021",
    "time": "6:00 AM",
    "price": "2999",
    "image": "assets/Dashboard/yoga-icon.png",
  };
  int tax = 0;
  int total = 0;
  @override
  void initState() {
    tax = (int.parse(program['price']!) * 0.01).round();
    total = int.parse(program['price']!) + tax;
    super.initState();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Options',
          style: paymentstyle,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white, // Changed background color to white
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        color: lightred2), // Added border with lightred2 color
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            program['image']!,
                            fit: BoxFit.cover,
                            width: 76.w,
                            height: 76.h,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                program['name']!,
                                style: paymentstyle6,
                              ),
                              Text(
                                '${program['trainer']}',
                                style: paymentstyle7,
                              ),
                              Text(
                                '${program['Duration']!}  • ${program['location']} ',
                                style: paymentstyle7,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: red1,
                                  ),
                                  Text(
                                    '${program['startingdate']!} • ${program['time']}',
                                    style: paymentstyle7,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: paymentstyle5,
                          ),
                          Text(
                            '₹2999.0',
                            style: paymentstyle5,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'UPI',
                  style: paymentstyle6,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            boxShadow: [
                              isChecked
                                  ? const BoxShadow(
                                      color: red3,
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: Offset(0, -2),
                                    )
                                  : const BoxShadow(
                                      color: red3,
                                      spreadRadius: 0,
                                      blurRadius: 12.7,
                                      offset: Offset(0, -3),
                                    )
                            ],
                            color: white100,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: lightred2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    'https://s3-alpha-sig.figma.com/img/91cf/9c5f/e34ec39a0bccdb189d1e7ec8e6f0208a?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=k0Oo~-05qHuKUI0WonEy8c5l6FFr5IVUbdaLl092zqOXB-XbhR0-xjMLG7ET8rfxpQiZMHJNozTxNUtqW7PMgOAo4P6SZQfPgAFjMqvZnV5NxzjkIpQOeLb5fiz-VFP1Wl6l98D122jP3LRfPi1RntneDyORXdrn-fkTVrM9zo6ig0p~cF4LR7QiQffqKxKWd3Nt3yph5uSKIUVHRJfSnVeZEkWX33S51c7WOLOqc0L8D2qVfDi6bWwRi1onT0fPjjgHOikuL20yfMyAdZQi88pfKYgBoI7DN0uzlajn0y7jLfDGC6PFeZsvo-0H2dKHU0UpSSZN9jsbs7XPycRoQQ__',
                                    width: 35.w,
                                    height: 30.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Google Pay',
                                        style: paymentstyle6,
                                      ),
                                      Text(
                                        'Pay using Google Pay',
                                        style: paymentstyle7,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Checkbox(
                                activeColor: red1,
                                shape: const CircleBorder(),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 98.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: white100,
                boxShadow: const [
                  BoxShadow(
                    color: lightgrey,
                    spreadRadius: 0,
                    blurRadius: 12.7,
                    offset: Offset(0, -3),
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '₹$total',
                          style: paymentstyle2,
                        ),
                        GestureDetector(
                          onTap: () => showDialog<String>(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) => BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Dialog(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(32.r),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: black900,
                                          spreadRadius: 0,
                                          blurRadius: 50,
                                          offset: Offset(0, 7),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 10.h),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 50.h,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Payment Total',
                                                  style: paymentstyle7,
                                                ),
                                              ),
                                              Text('₹$total',
                                                  style: paymentstyle8),
                                              SizedBox(height: 30.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Date',
                                                    style: paymentstyle7,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    program['startingdate']!,
                                                    style: paymentstyle9,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Details',
                                                    style: paymentstyle7,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    program['name']!,
                                                    style: paymentstyle9,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Account',
                                                    style: paymentstyle7,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    program['trainer']!,
                                                    style: paymentstyle9,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              const Divider(),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Total Payment',
                                                    style: paymentstyle7,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '₹${program['price']!}',
                                                    style: paymentstyle9,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Tax',
                                                    style: paymentstyle7,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '₹${tax.toString()}',
                                                    style: paymentstyle9,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Total ',
                                                    style: paymentstyle9,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '₹$total',
                                                    style: paymentstyle9,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Transform.translate(
                                              offset: const Offset(0, -60),
                                              child: Image.asset(
                                                'assets/Paymentpage/success_icon.png',
                                                fit: BoxFit.cover,
                                                height: 98.h,
                                                width: 98.w,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            'View detailed bill',
                            style: paymentstyle3,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print('gpay');
                          startpayment();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(159.w, 47.h),
                          backgroundColor: red1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text('Proceed to pay', style: paymentstyle4))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startpayment() async {
    try {
      FlutterPayment flutterPayment = FlutterPayment();
      flutterPayment.launchUpi(
          upiId: "rishikeshsabu1@oksbi",
          name: "Rishikesh Sabu",
          amount: "1",
          message: "test",
          currency: "INR");
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PaymentConfirmationPage()));
      });
    } catch (e) {
      print(e);
    }
  }
}
