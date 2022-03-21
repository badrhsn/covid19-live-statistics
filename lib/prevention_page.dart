import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'constant.dart';
import 'prevention-card.dart';
import 'providers/app_provider.dart';

class Prevention extends StatefulWidget {
  _PreventionState createState() => _PreventionState();
}

class _PreventionState extends State<Prevention> {
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    bool isCollapsed = appProvider.isCollapsed;
    bool isDecorated = appProvider.isDecorated;
    print(isCollapsed);
    AnimationController _controller = appProvider.getAnimationController();
    Animation _scaleAnimation = appProvider.getScaleAnimation();
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.5 * screenWidth,
        right: isCollapsed ? 0 : -0.7 * screenWidth,
        child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: isDecorated
                      ? BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(45))
                      : null,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.3), blurRadius: 20)
                  ],
                  color: Colors.white,
                ),
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.width * 0.88,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    covidSecondaryColor,
                                    covidPrimaryColor
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(.6),
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: isDecorated
                                      ? Radius.circular(50)
                                      : Radius.circular(0)),
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 45, left: 20),
                                  child: IconButton(
                                    alignment: Alignment.topLeft,
                                    icon: SvgPicture.asset(
                                        "assets/icons/menu.svg"),
                                    onPressed: () {
                                      if (isCollapsed)
                                        _controller.forward();
                                      else
                                        _controller.reverse();

                                      appProvider.setCollapesed();
                                      appProvider.setDecorated();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            "COVID - 19",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Symptoms",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ]),
                                Padding(
                                  padding: EdgeInsets.only(left: 0.0, top: 0.0),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      height: 150,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: true,
                                      autoPlayInterval:
                                          new Duration(seconds: 4),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 2000),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                    ),
                                    items: [
                                      Row(children: <Widget>[
                                        SizedBox(width: 20),
                                        Expanded(
                                            child: Text(
                                          "People may be sick with the virus for 1 to 14 days before developping symptoms",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        SvgPicture.asset(
                                          "assets/icons/sneeze.svg",
                                          width: 110,
                                        ),
                                        SizedBox(width: 20),
                                      ])
                                    ],
                                  ),
                                ),
                              ]),
                        ]),
                        Flexible(
                            child: CustomScrollView(slivers: <Widget>[
                          SliverList(
                              delegate: SliverChildListDelegate(<Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, top: 40.0, right: 20),
                              child: Column(children: <Widget>[
                                Row(children: <Widget>[
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: "Preventions\n",
                                      style: covidTitleTextstyle,
                                    ),
                                    TextSpan(
                                        text: "Don't Leave Your Home",
                                        style: TextStyle(
                                          color: covidTextLightColor,
                                        ))
                                  ])),
                                  Spacer(),
                                  Text("#StayAtHome",
                                      style: TextStyle(
                                        color: covidPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ]),
                                SizedBox(height:20),
                                Column(children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 30,
                                                color: covidShadowColor)
                                          ]),
                                      child: Column(children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              PreventionCard(
                                                imageurl:
                                                    preventionImage1,
                                                title: preventionText1,
                                              ),
                                              PreventionCard(
                                                imageurl:
                                                    preventionImage2,
                                                title: preventionText2,
                                              ),
                                              PreventionCard(
                                                imageurl:
                                                    preventionImage3,
                                                title: preventionText3,
                                              ),
                                            ]),
                                            SizedBox(height:20),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              PreventionCard(
                                                imageurl:
                                                    preventionImage4,
                                                title: preventionText4,
                                              ),
                                              PreventionCard(
                                                imageurl:
                                                    preventionImage5,
                                                title: preventionText5,
                                              ),
                                              PreventionCard(
                                                imageurl:
                                                    preventionImage6,
                                                title: preventionText6,
                                              ),
                                            ]),
                                      ])),
                                ])
                              ]),
                            )
                          ]))
                        ]))
                      ]),
                ))));
  }
}
