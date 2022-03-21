import 'package:covid19/homesecreen.dart';
import 'package:covid19/prevention_page.dart';
import 'package:covid19/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'constant.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  bool isDecorated = false;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  int index;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);

    Provider.of<AppProvider>(context, listen: false)
        .setanimationController(_controller);
    Provider.of<AppProvider>(context, listen: false)
        .setScaleAnimation(_scaleAnimation);
    Provider.of<AppProvider>(context, listen: false)
        .setMenuScaleAnimation(_menuScaleAnimation);
    Provider.of<AppProvider>(context, listen: false)
        .setSlideAnimation(_slideAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    index = Provider.of<AppProvider>(context, listen: false).getPageIndex();

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: covidPrimaryColor,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [covidSecondaryColor, covidPrimaryColor])),
          child: Stack(
            children: <Widget>[
              menu(context),
              Container(child: index == 0 ? HomeSecreen() : Prevention())
            ],
          )),
    );
  }

  Widget menu(context) {
    var appProvider = Provider.of<AppProvider>(context);

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  height: 300,
                ),
                Row(children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/home.svg",
                    width: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: appProvider.getPageIndex() ==0 ? FontWeight.w900 : null),
                      ),
                      onTap: () {
                        if (isCollapsed)
                          _controller.reverse();
                        else
                          _controller.forward();
                        appProvider.setPageIndex(0);
                        appProvider.setCollapesed();
                        appProvider.setDecorated();
                      })
                ]),
                Divider(
                  height: 20,
                ),
                Row(children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/news.svg",
                    width: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Covid-19 News",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ]),
                Divider(
                  height: 20,
                ),
                Row(children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/prevention.svg",
                    width: 25,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                      child: Text(
                        "Preventions",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: appProvider.getPageIndex() ==1 ? FontWeight.w900 : null
                        ),
                      ),
                      onTap: () {
                        if (isCollapsed)
                          _controller.reverse();
                        else
                          _controller.forward();
                        appProvider.setPageIndex(1);
                        appProvider.setCollapesed();
                        appProvider.setDecorated();
                      })
                ]),
                Container(
                    margin: EdgeInsets.only(top: 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "COVID 19",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        Text("Virus tracker",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CovidClippper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
