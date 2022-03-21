import 'package:flutter/material.dart';

import 'constant.dart';
import 'minicounter.dart';

class MostInfected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        
          child: Stack(
            
            children: <Widget>[
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: covidShadowColor),
              ]),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset("assets/images/260-united-kingdom.png"),
                )),
                MiniCounter(
                  title: "Infected",
                  number: 190,
                  color: covidInfectedColor,
                ),
                MiniCounter(
                  title: "Death",
                  number: 70,
                  color: covidDeathColor,
                ),
                MiniCounter(
                  title: "Recovered",
                  number: 66,
                  color: covidRecoverColor,
                ),
                MiniCounter(
                  title: "Critical",
                  number: 50,
                  color: covidCriticalColor,
                ),
              ]),
        ),
      ])),
      SizedBox(height:10),
      SizedBox(
          child: Stack(children: <Widget>[
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: covidShadowColor),
              ]),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset("assets/images/128-spain.png"),
                )),
                MiniCounter(
                  title: "Infected",
                  number: 200,
                  color: covidInfectedColor,
                ),
                MiniCounter(
                  title: "Death",
                  number: 90,
                  color: covidDeathColor,
                ),
                MiniCounter(
                  title: "Recovered",
                  number: 78,
                  color: covidRecoverColor,
                ),
                MiniCounter(
                  title: "Critical",
                  number: 223,
                  color: covidCriticalColor,
                ),
              ]),
        ),
      ])),
            SizedBox(height:10),

      SizedBox(
          child: Stack(children: <Widget>[
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: covidShadowColor),
              ]),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset("assets/images/013-italy.png"),
                )),
                MiniCounter(
                  title: "Infected",
                  number: 100,
                  color: covidInfectedColor,
                ),
                MiniCounter(
                  title: "Death",
                  number: 87,
                  color: covidDeathColor,
                ),
                MiniCounter(
                  title: "Recovered",
                  number: 23,
                  color: covidRecoverColor,
                ),
                MiniCounter(
                  title: "Critical",
                  number: 32,
                  color: covidCriticalColor,
                ),
              ]),
        ),
      ])),
    ]);
  }
}
