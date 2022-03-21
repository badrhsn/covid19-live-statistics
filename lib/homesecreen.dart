import 'package:covid19/constant.dart';
import 'package:covid19/country_details.dart';
import 'package:covid19/models/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:covid19/counter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'my_clipper.dart';
import 'providers/app_provider.dart';
import 'providers/country_details_provider.dart';
import 'providers/country_provider.dart';
import 'providers/page_details_provider.dart';
import 'providers/worldwide_provider.dart';

class HomeSecreen extends StatefulWidget {
  _HomeSecreenState createState() => _HomeSecreenState();
}

class _HomeSecreenState extends State<HomeSecreen> {
  final Duration duration = const Duration(milliseconds: 300);
  double screenWidth, screenHeight;
  bool isLoading = false;
  List<Country> list = new List<Country>();
  List<String> listOfCountries =new List<String>();

  String _selectedLocation = "United Kingdom";
  final numberFormat = NumberFormat.compact();

  @override
  void initState() {
    super.initState();

    Provider.of<WorldwideProvider>(context, listen: false)
        .getWorldWideProvider();
    Provider.of<CountryProvider>(context, listen: false).getCountryProvider();
    Provider.of<CountryDetailsProvider>(context, listen: false)
        .getCountryDetailsProvider(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    var worldwide = Provider.of<WorldwideProvider>(context).worldWide;
    var countryDetails =
        Provider.of<CountryDetailsProvider>(context).countryDetails;
    var country = Provider.of<CountryProvider>(context).country;

 


    DateFormat dateFormat = DateFormat();

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
                  children: <Widget>[
                    ClipPath(
                        clipper: CovidClippper(),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 35, top: 50, right: 20),
                          height: 290,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: isDecorated
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(45),
                                      bottomLeft: Radius.circular(40))
                                  : null,
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromRGBO(14, 98, 81, 1),
                                    Color.fromRGBO(23, 165, 137, 1)
                                  ]),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/homecover.png"))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                  alignment: Alignment.topLeft,
                                  icon:
                                      SvgPicture.asset("assets/icons/menu.svg"),
                                  onPressed: () {
                                    
                                    if (isCollapsed)
                                      _controller.forward();
                                    else
                                      _controller.reverse();

                                    appProvider.setCollapesed();
                                    appProvider.setDecorated();
                                  },
                                ),
                              ]),
                        )),
                    Flexible(
                        child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                            delegate: SliverChildListDelegate(<Widget>[
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "Worldwide Update\n",
                                        style: covidTitleTextstyle,
                                      ),
                                      TextSpan(
                                          text: "Last Update ",
                                          style: TextStyle(
                                              color: covidTextLightColor,
                                              fontSize: 12)),
                                      TextSpan(
                                          text: worldwide?.lastUpdate != null
                                              ? dateFormat
                                                  .format(worldwide?.lastUpdate)
                                              : "",
                                          style: TextStyle(
                                              color: covidTextLightColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold))
                                    ]))
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 8.0,
                                      bottom: 12),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                      "assets/icons/square.svg",
                                                      color: covidInfectedColor,
                                                      width: 25),
                                                  SizedBox(width: 6),
                                                  Text(
                                                      worldwide?.confirmed
                                                                   !=
                                                              null
                                                          ? numberFormat.format(
                                                              worldwide
                                                                  ?.confirmed
                                                                  )
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              covidInfectedColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 25))
                                                ],
                                              ),
                                              Text("Confirmed")
                                            ]),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                      "assets/icons/square.svg",
                                                      color: covidDeathColor,
                                                      width: 25),
                                                  SizedBox(width: 10),
                                                  Text(
                                                      worldwide?.deaths !=
                                                              null
                                                          ? numberFormat.format(
                                                              worldwide?.deaths
                                                                  )
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              covidDeathColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 25))
                                                ],
                                              ),
                                              Text("Deaths")
                                            ]),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                      "assets/icons/square.svg",
                                                      color: covidRecoverColor,
                                                      width: 25),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    worldwide?.recovered
                                                                 !=
                                                            null
                                                        ? numberFormat.format(
                                                            worldwide?.recovered
                                                                )
                                                        : "",
                                                    style: TextStyle(
                                                        color:
                                                            covidRecoverColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 25),
                                                  )
                                                ],
                                              ),
                                              Text("Recovered")
                                            ])
                                      ]),
                                )
                              ])),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Color(0xFFE5E5E5),
                                )),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/icons/maps-and-flags.svg",
                                  width: 15,
                                  color: covidPrimaryColor,
                                ),
                                SizedBox(width: 23),
                                Expanded(
                                  child: DropdownButton(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      icon: SvgPicture.asset(
                                        "assets/icons/dropdown.svg",
                                        width: 15,
                                        color: covidPrimaryColor,
                                      ),
                                      value: _selectedLocation,
                                      onChanged: (newValue) async {
                                        print(newValue);
                                        setState(() {
                                          _selectedLocation = newValue;
                                          isLoading = true;
                                        });
                                        await Provider.of<
                                                    CountryDetailsProvider>(
                                                context,
                                                listen: false)
                                            .getCountryDetailsProvider(
                                                newValue);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                      items: country != null
                                          ? country.countries
                                              .map((val) => DropdownMenuItem(
                                                    value: val.name,
                                                    child: Text(
                                                      val.name,
                                                    ),
                                                  ))
                                              .toList()
                                          : null),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(children: <Widget>[
                              Row(children: <Widget>[
                                Expanded(child: RichText(
                                    text: TextSpan(
                                      children: [
                                  TextSpan(
                                      text: _selectedLocation,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:  18,
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                  TextSpan(
                                    text: " Live Stats\n",
                                    style: covidTitleTextstyle,
                                  ),
                                  TextSpan(
                                      text: "Last Update ",
                                      style: TextStyle(
                                          color: covidTextLightColor,
                                          fontSize: 12)),
                                  TextSpan(
                                      text: countryDetails?.lastUpdate != null
                                          ? dateFormat.format(
                                              countryDetails?.lastUpdate)
                                          : "",
                                      style: TextStyle(
                                          color: covidTextLightColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))
                                ]))),
                                Row(children: <Widget>[
                                  FlatButton(
                                    padding: EdgeInsets.only(left: 7, right: 5),
                                      color: covidPrimaryColor,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                                      onPressed: () {
                                        Provider.of<PageDetailsProvider>(
                                                context,
                                                listen: false)
                                            .setCountrySelected(
                                                _selectedLocation);
                                        Provider.of<PageDetailsProvider>(
                                                context,
                                                listen: false)
                                            .setCountryDeatailsModel(
                                                countryDetails);        
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                transitionDuration:
                                                    Duration(seconds: 1),
                                                transitionsBuilder:
                                                    (BuildContext context,
                                                        Animation<double>
                                                            animation,
                                                        Animation<double>
                                                            secanimation,
                                                        Widget child) {
                                                  animation = CurvedAnimation(
                                                      parent: animation,
                                                      curve:
                                                          Curves.elasticInOut);
                                                  return ScaleTransition(
                                                    scale: animation,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: child,
                                                  );
                                                },
                                                pageBuilder: (
                                                  BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secanimation,
                                                ) {
                                                  return CountryDetails();
                                                }));
                                      },
                                      child: Row(children: <Widget>[
                                        Text("see details",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            )),
                                        SvgPicture.asset(
                                            "assets/icons/next.svg",
                                            width: 15,
                                            color: Colors.white)
                                      ])),
                                  SizedBox(width: 5),
                                ])
                              ]),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 30,
                                          color: covidShadowColor)
                                    ]),
                                child: !isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                            Counter(
                                                color: covidInfectedColor,
                                                number: countryDetails
                                                            ?.confirmed
                                                            ?.value !=
                                                        null
                                                    ? numberFormat.format(
                                                        countryDetails
                                                            ?.confirmed?.value)
                                                    : "",
                                                title: "Confirmed"),
                                            Counter(
                                                color: covidDeathColor,
                                                number: countryDetails
                                                            ?.deaths?.value !=
                                                        null
                                                    ? numberFormat.format(
                                                        countryDetails
                                                            ?.deaths?.value)
                                                    : "",
                                                title: "Death"),
                                            Counter(
                                                color: covidRecoverColor,
                                                number: countryDetails
                                                            ?.recovered
                                                            ?.value !=
                                                        null
                                                    ? numberFormat.format(
                                                        countryDetails
                                                            ?.recovered?.value)
                                                    : "",
                                                title: "Recovered"),
                                          ])
                                    : Center(
                                        child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                covidPrimaryColor),
                                      )),
                              ),
                              SizedBox(height: 20),
                              /*Row(
                                children: <Widget>[
                                Text(
                                  "Most Infected\n",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                ),
                              ]
                              ),
                              MostInfected()*/
                            ]),
                          )
                        ]))
                      ],
                    ))
                  ],
                )))));
  }
}
