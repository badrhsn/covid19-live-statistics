import 'package:covid19/constant.dart';
import 'package:covid19/models/country_details.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/page_details_provider.dart';


class DataChart extends StatefulWidget{

  _DataChartState createState() => _DataChartState();

}

class _DataChartState extends State<DataChart> {

        int touchedIndex;
        DetailCountry _countryDetails;
   

List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: covidInfectedColor,
            value: _countryDetails?.confirmed?.value?.toDouble(),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: covidDeathColor,
            value: _countryDetails?.deaths?.value?.toDouble(),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: covidRecoverColor,
            value: _countryDetails?.recovered?.value?.toDouble(),
            title:'',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
@override
void initState(){
super.initState();

    _countryDetails = Provider.of<PageDetailsProvider>(context, listen: false)
        .getCountryDetailsModel();

}
   
  @override
  Widget build(BuildContext context) {



    return 
            Container(
              width: 230,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                )
          );
  }
}
