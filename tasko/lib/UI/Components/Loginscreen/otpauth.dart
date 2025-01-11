import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasko/UI/Screens/Intro/get_started_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Services/API/phone_auth.dart';
import '../../Themes/colors.dart';
import '../../Themes/styles.dart';

class OtpAuth extends StatefulWidget {
  final Function nextPage;
  const OtpAuth({super.key, required this.nextPage});

  @override
  State<OtpAuth> createState() => _OtpAuthState();
}

class _OtpAuthState extends State<OtpAuth> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  String otp = '';
  bool verifying = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, top: 32.h, right: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OTP',
            style: headingStyle,
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            'A 4 digit OTP has been send to your mobile number',
            style: pStyle,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 68,
                width: 64,
                child: Center(
                  child: TextField(
                    style: otpstlyle,
                    controller: controller1,
                    cursorColor: Colors.grey,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                        otp = otp + controller1.text;
                      }
                    },
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 68,
                width: 64,
                child: Center(
                  child: TextField(
                    style: otpstlyle,
                    controller: controller2,
                    cursorColor: Colors.grey,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                        otp = otp + controller2.text;
                      }
                    },
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 68,
                width: 64,
                child: Center(
                  child: TextField(
                    style: otpstlyle,
                    controller: controller3,
                    cursorColor: Colors.grey,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                        otp = otp + controller3.text;
                      }
                    },
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 68,
                width: 64,
                child: Center(
                  child: TextField(
                    style: otpstlyle,
                    cursorColor: Colors.grey,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    controller: controller4,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      otp = otp + controller4.text;
                    },
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 35.h,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: white400,
                backgroundColor: red,
                minimumSize: Size(340.w, 60.h),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(13),
                )),
              ),
              onPressed: () async {
                if (otp == '') {
                  Fluttertoast.showToast(
                      msg: 'Please enter the OTP',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  //  Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: ((context) => const GetStartedPage()),
                  //   ),
                  // );                           // for testing only //
                  setState(() {
                    verifying = true; //uncomment this block
                  });
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final String? phoneNo = prefs.getString('phoneNo');
                  var status = await PhoneAuth.verifyOtp(phoneNo!, otp);
                  if (status == 'approved') {
                    // if otp is verified is correct correct it!!!
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: ((context) => const GetStartedPage()),
                      ),
                    );
                  } else {
                    setState(() {
                      verifying = false;
                      otp = '';
                    });
                    Fluttertoast.showToast(
                        msg: 'Invalid OTP',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }
              },
              child: verifying
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Verify',
                      style: btnstyle,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
