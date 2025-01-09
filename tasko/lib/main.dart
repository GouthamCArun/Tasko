import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasko/UI/Screens/SplashScreen/splash_screen.dart';
import 'package:tasko/UI/Screens/home/dashboard_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'UI/Components/DetailsScreen/dash_try.dart';

// import 'UI/Screens/home/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 200));
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://duwrenrgqabtglpjnbcd.supabase.co',
    anonKey:
        '',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
