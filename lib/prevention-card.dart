import 'package:flutter/material.dart';

class PreventionCard extends StatelessWidget {

final String imageurl;
final String title;

 const PreventionCard({
    Key key,
    this.imageurl,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Image.asset(imageurl, width: 45),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:12,
              fontWeight: FontWeight.w600
            ),
          )
        ]));
  }
}
