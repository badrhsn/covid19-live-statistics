import 'package:covid19/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'chart.dart';
import 'counter_details.dart';
import 'models/country_details.dart';
import 'providers/page_details_provider.dart';

class CountryDetails extends StatefulWidget {
  @override
  _CountryDetails createState() => _CountryDetails();
}

class _CountryDetails extends State<CountryDetails> {
  String _countrySelected;
  DetailCountry _countryDetails;
  NumberFormat nbFormat = new NumberFormat();
  DateFormat dateFormat = new DateFormat();

  @override
  void initState() {
    super.initState();
    _countrySelected = Provider.of<PageDetailsProvider>(context, listen: false)
        .getcontrySelected();
    _countryDetails = Provider.of<PageDetailsProvider>(context, listen: false)
        .getCountryDetailsModel();
  }

  @override
  Widget build(BuildContext context) {

    double recoveryRate = ((_countryDetails?.recovered?.value / _countryDetails?.confirmed?.value) * 100);
    double fatalityRate = ((_countryDetails?.deaths?.value / _countryDetails?.confirmed?.value) * 100);

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: covidPrimaryColor,
              border: Border.all(color: covidPrimaryColor)),
          child: Padding(
              padding: EdgeInsets.only(top: 35, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/left-arrow.svg",
                        color: Colors.white, width: 28),
                    onPressed: () {
                        Navigator.pop(context);
                    },
                  ),
                ],
              )),
        ),
        Stack(children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 350,
              decoration: BoxDecoration(color: covidPrimaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _countryDetails.flag == null
                          ? SvgPicture.asset(
                              "assets/icons/world.svg",
                              width: 35,
                              fit: BoxFit.fill,
                              color: Colors.white,
                            )
                          : FadeInImage.assetNetwork(
                            width: 40,
                            
                              placeholder: 'assets/images/world.png',
                              image: _countryDetails.flag,
                            ),
                      SizedBox(width: 20),
                      Expanded(child: Text(_countrySelected,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Poppins",
                              fontSize: 20,
                              color: Colors.white))),
                    ],
                  ),
                  Text(
                    "Last updated ${dateFormat.format(_countryDetails?.lastUpdate)}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100, left: 15.0, right: 15.0),
            child: Container(
              width: double.infinity,
              height: 370,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.16),
                      offset: Offset(0.0, 3.0),
                      blurRadius: 15,
                    )
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Active Cases",
                                  style: covidTitleTextstyle,
                                ),
                                Text(
                                    nbFormat.format(((_countryDetails
                                                ?.confirmed?.value -
                                            _countryDetails?.recovered?.value) -
                                        _countryDetails?.deaths?.value)),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.orange))
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.show_chart,
                                color: covidPrimaryColor,
                              ),
                              onPressed: null,
                              iconSize: 35,
                            )
                          ]),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: DataChart(),
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Text(
                                  '${recoveryRate.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                      color: covidRecoverColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Recovery Rate",
                                  style: TextStyle(
                                      color: covidRecoverColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                SizedBox(height: 20),
                                Text(
                                    "${fatalityRate.toStringAsFixed(2)}%",
                                    style: TextStyle(
                                        color: covidDeathColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20)),
                                Text(
                                  "Fatality Rate",
                                  style: TextStyle(
                                      color: covidDeathColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ]))
                        ])
                  ]),
            ),
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(left: 0.0, top: 20.0),
          child: Container(
            height: 140,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15),
              ),
              CounterDetails(
                  color1: covidInfectedColor,
                  color2: covidInfectedColor.withOpacity(.3),
                  title: "Confirmed",
                  number: nbFormat.format(_countryDetails?.confirmed?.value),
                  iconUrl: "assets/icons/virus.svg",
                  iconColor: Color.fromRGBO(147, 81, 22, 1)),
              CounterDetails(
                  color1: covidDeathColor,
                  color2: covidDeathColor.withOpacity(.3),
                  title: "Deaths",
                  number: nbFormat.format(_countryDetails?.deaths?.value),
                  iconUrl: "assets/icons/death.svg",
                  iconColor: Color.fromRGBO(192, 57, 43, 1)),
              CounterDetails(
                color1: covidRecoverColor,
                color2: covidRecoverColor.withOpacity(.3),
                title: "Recovered",
                number: nbFormat.format(_countryDetails?.recovered?.value),
                iconUrl: "assets/icons/heart.svg",
                iconColor: Color.fromRGBO(20, 90, 50, 1),
              ),
            ]),
          ),
        ),
      ],
    )));
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 470.0 - 200);
    path.quadraticBezierTo(size.width / 2, 280, size.width, 400.0 - 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
