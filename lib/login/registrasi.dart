// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_course/dashboard/home.dart';
import 'package:flutter_course/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registrasi extends StatefulWidget {
  const Registrasi({super.key});

  @override
  State<Registrasi> createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            const Text('Registrasi',
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 20, right: 20, bottom: 15),
              child: TextField(
                controller: usernameController,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      // borderSide: BorderSide(width: 1, color: const Color.fromARGB(255, 255, 255, 255),style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Username',
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
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child: TextField(
                controller: emailController,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway_Thin',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: TextField(
                controller: passwordController,
                onChanged: (value) {
                  setState(() {});
                },
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
              onPressed: () {
                _saveUserData();
                // _redirectToLogin();
              },
              child: const Text(
                'Sign Up',
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
                          builder: (context) => const Login(),
                        ));
                  },
                  child: const Text(
                    ' have any account?\b login here!',
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

  _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString(
        '${emailController.text}_username'); // Gunakan email sebagai kunci
    if (savedEmail != null) {
      _showErrorAlert("Email sudah terdaftar!");
    } else {
      await prefs.setString(
          '${emailController.text}_username', usernameController.text);
      await prefs.setString(
          '${emailController.text}_password', passwordController.text);
      await prefs.setString(
          '${usernameController.text}_name', usernameController.text);
      await prefs.setString(
          '${usernameController.text}_email', emailController.text);

      _showSavedAlert();
    }
  }

  void _showSavedAlert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('${emailController.text}_username');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Data berhasil disimpan!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(
                        username: savedUsername,
                      ),
                    ));
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
