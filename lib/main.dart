import 'package:flutter/material.dart';
import 'package:football_points/tela_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          textTheme: TextTheme(
            button: TextStyle(fontSize: 45.sp),
          ),
        ),
        home: TelaLogin(),
      ),
    );
  }
}
