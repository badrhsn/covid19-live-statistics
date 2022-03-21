import 'package:covid19/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer.dart';
import 'providers/app_provider.dart';
import 'providers/country_details_provider.dart';
import 'providers/country_provider.dart';
import 'providers/page_details_provider.dart';
import 'providers/worldwide_provider.dart';

void main() => runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WorldwideProvider()),
    ChangeNotifierProvider(create: (_) => AppProvider()),
    ChangeNotifierProvider(create: (_) => CountryDetailsProvider()),
    ChangeNotifierProvider(create: (_) => CountryProvider()),
    ChangeNotifierProvider(create: (_) => PageDetailsProvider()),

  ],
  child: MyApp(),)
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19 Stats & News',
      theme: ThemeData(
        scaffoldBackgroundColor: covidBackgroundColor,
        fontFamily: "Poppins",
        textTheme: TextTheme(body1: TextStyle(color: covidBodyTextColor))
      ),
      home: MyDrawer()
    );
  }
}

