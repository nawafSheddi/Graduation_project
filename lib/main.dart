import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/providers.dart';
import 'package:sonar/screens/basic_data/basic_data_page.dart';
import 'package:sonar/screens/home/home_page.dart';
import 'package:sonar/screens/more_info/more_info_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Manrope",
      ),
      routes: {
        "/": (context) => const BasicData(),
        BasicData.routeName: (context) => const BasicData(),
        HomePage.routeName: (context) => const HomePage(),
        MoreInfo.routeName: (context) => const MoreInfo(),
      },
    );
  }
}
