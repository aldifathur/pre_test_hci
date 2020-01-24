import 'package:flutter/material.dart';
import 'package:pre_test_hci/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomeScreen(),
        theme: ThemeData(primaryColor: Colors.cyan[300]),
        debugShowCheckedModeBanner: false);
  }
}
