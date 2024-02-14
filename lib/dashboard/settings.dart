import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  final String userId;

  const Settings({super.key, this.userId = ''});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  late String _profileImage = '';
  // String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProfileInfo();
  }

  Future<void> _loadProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('${widget.userId}_name') ?? '';
      _emailController.text = prefs.getString('${widget.userId}_email') ?? '';
      _phoneNumberController.text =
          prefs.getString('${widget.userId}_phoneNumber') ?? '';
      _dateController.text = prefs.getString('${widget.userId}_date') ?? '';
      _profileImage = prefs.getString('${widget.userId}_profileImage') ?? '';
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _changeProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('${widget.userId}_profileImage',
          pickedFile.path); // Save profile image
      setState(() {
        _profileImage = pickedFile.path;
      });
    }
  }

  void _saveProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('${widget.userId}_username', _nameController.text);
    prefs.setString('${widget.userId}_name', _nameController.text);
    prefs.setString('${widget.userId}_email', _emailController.text);
    prefs.setString(
        '${widget.userId}_phoneNumber', _phoneNumberController.text);
    prefs.setString('${widget.userId}_date', _dateController.text);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0D1E0),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ubuntu_Reg',
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  _profileImage.isEmpty
                      ? const Icon(
                          Symbols.account_circle,
                          size: 120,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(File(_profileImage)),
                          radius: 60,
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(158, 249, 249, 249),
                          shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(FontAwesomeIcons.pen),
                        onPressed: _changeProfileImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w900),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w900),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w900),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w900),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              ElevatedButton(
                autofocus: true,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 45)),
                  mouseCursor: MaterialStateMouseCursor.clickable,
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff0A0171),
                  ),
                ),
                onPressed: () {
                  _saveProfileInfo();
                },
                child: const Text(
                  'Save Change\'s',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
