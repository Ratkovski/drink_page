import '/pages/init_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktail App',
      debugShowCheckedModeBanner: false,
      home: InitPage(),
    );
  }
}
