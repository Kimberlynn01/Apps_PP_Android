import 'package:flutter/material.dart';
import 'package:flutter_course/login/login.dart';

void main() {
  runApp(const MaterialApp(
    home: Apps(),
    debugShowCheckedModeBanner: false,
  ));
}

class Apps extends StatefulWidget {
  const Apps({super.key});

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Login(),
    );
  }
}
