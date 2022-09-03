import 'package:flutter/material.dart';
import 'package:samples/app_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppPage(),
    );
  }
}
