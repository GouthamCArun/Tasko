import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasko/UI/Themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Toggle extends StatefulWidget {
  const Toggle({super.key});

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  List<String> gender = ['Male', 'Female', 'Others'];
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      activeBgColor: const [red],
      fontSize: 16.sp,
      minHeight: 66.h,
      minWidth: 107.w,
      inactiveBgColor: const Color.fromRGBO(118, 118, 128, 0.12),
      labels: gender,
      onToggle: (index) async {
        print(gender[index!]);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('gender', gender[index]);
      },
    );
  }
}
