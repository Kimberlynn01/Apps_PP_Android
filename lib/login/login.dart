// ignore_for_file: use_build_context_synchronously, sort_child_properties_last, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_course/dashboard/home.dart';
import 'package:flutter_course/login/registrasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString(_emailController.text);
    String? savedPassword =
        prefs.getString('${_emailController.text}_password');
    String? savedUsername =
        prefs.getString('${_emailController.text}_username');

    String inputPassword = _passwordController.text;

    if (savedPassword != null && savedPassword == inputPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(username: savedUsername),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Email atau password salah';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0171),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/vektor_login.png',
                  width: 200.25,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text('Welcome Admin!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Raleway_Bold')),
            const SizedBox(
              height: 23,
            ),
            const Text(
              'Please Log into your existing account',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway_Light',
                  fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Your Email',
                  focusColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway_Thin',
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway_Thin',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text(
                'Log in',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway_Bold',
                    fontSize: 20),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
                minimumSize: MaterialStateProperty.all(const Size(300, 58)),
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff2BC990),
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Registrasi(),
                        ));
                  },
                  child: const Text(
                    'don\'t have any account?\b register here!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
