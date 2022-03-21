import 'package:flutter/material.dart';


class MiniCounter extends StatelessWidget {
    final int number;
  final String title;
  final Color color;

  const  MiniCounter({
    Key key,
    this.number,
    this.title,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$number'"k",
          style: TextStyle(fontSize: 25, color: color,fontWeight: FontWeight.w800),
        ),
        Text("$title",style: TextStyle(fontSize:10)),
      ],
    ));
  }
}
