import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CounterDetails extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color iconColor;
  final String title;
  final String number;
  final String iconUrl;

  CounterDetails({this.color1, this.color2, this.title, this.number, this.iconUrl, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: Container(
          width: 220,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color1,
                    color2,
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children:<Widget>[
                    SvgPicture.asset("$iconUrl",
                    width:40,
                    color: iconColor,),
                    SizedBox(width:20),
                    Text("$title",
                    style: TextStyle(
                      fontSize:20,
                      fontWeight: FontWeight.w100
                    ))
                  ]
                ) ,
                SizedBox(height:10),
                Text("$number",
                style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold
                ),)
                
                ],
            ),
          )),
    );
  }
}
