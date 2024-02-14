// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/dashboard/settings.dart';
import 'package:flutter_course/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  String? username;
  final String userId;

  Dashboard({super.key, this.username, this.userId = ''});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.username = prefs.getString('${widget.username}_username') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Color(0xFFD0D1E0),
        color: Color(0xff0A0171),
        items: const <Widget>[
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.insert_photo_rounded, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ],
        onTap: (value) {
          setState(
            () {
              _currentIndex = value;
            },
          );
        },
      ),
      backgroundColor: Color(0xFFD0D1E0),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello User!',
                        style: TextStyle(
                            fontFamily: 'Raleway_Bold',
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.username ?? '',
                            style: TextStyle(
                              color: Color.fromARGB(255, 76, 75, 75),
                              fontSize: 26,
                              fontFamily: 'Bebas_Reg',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          PopupMenuButton(
                            offset: Offset(-20, 45),
                            color: Color(0xff0A0171),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            icon: Icon(FontAwesomeIcons.userLargeSlash,
                                color: Color.fromARGB(255, 26, 26, 26)),
                            itemBuilder: (context) => <PopupMenuEntry>[
                              PopUpItems(
                                value: 'Settings',
                                label: 'Settings',
                                icon: Icons.settings,
                                onTap: () => setState(() {
                                  _bottomNavigationKey.currentState?.setPage(2);
                                  Navigator.pop(context);
                                }),
                              ),
                              PopupMenuDivider(),
                              PopUpItems(
                                  value: 'Redeem',
                                  label: 'Redeem Code',
                                  icon: Icons.redeem),
                              PopupMenuDivider(),
                              PopUpItems(
                                value: 'Logout',
                                label: 'Logout',
                                icon: Icons.logout,
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Buatlah Portfolio anda disini!',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Ubuntu_Bold'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                        ),
                        items: [
                          Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              // color: Colors.deepPurple[100],
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const Scaffold(),
          // const Settings(),
          Settings(userId: widget.username!),
        ],
      ),
    );
  }
}

class PopUpItems extends PopupMenuEntry<String> {
  final String value;
  final String label;
  final IconData icon;
  final Function? onTap;

  const PopUpItems({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(String? value) => false;

  @override
  State<PopUpItems> createState() => _PopUpItemsState();
}

class _PopUpItemsState extends State<PopUpItems> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(widget.icon, color: Colors.white),
            SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
