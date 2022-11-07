import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sonar/firebase_options.dart';
import 'package:sonar/providers/providers.dart';
import 'package:sonar/screens/OTP_screen/OTP_screen.dart';
import 'package:sonar/screens/add_offer/add_offer.dart';
import 'package:sonar/screens/basic_data/basic_data_page.dart';
import 'package:sonar/screens/home/home_page.dart';
import 'package:sonar/screens/likes_list/likes_screen.dart';
import 'package:sonar/screens/more_info/more_info_page.dart';
import 'package:sonar/screens/offer_screen/offer_screen.dart';
import 'package:sonar/screens/profile/profile_screen.dart';
import 'package:sonar/screens/signIn_screen/singnIn_screen.dart';
import 'package:sonar/screens/splash_page/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('appDB');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: getProviders(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
        "/": (context) => const SplashScreenPage(),
        BasicData.routeName: (context) => const BasicData(),
        HomePage.routeName: (context) => const HomePage(),
        MoreInfo.routeName: (context) => const MoreInfo(),
        OfferScreen.routeName: (context) => const OfferScreen(),
        LikesScreen.routeName: (context) => const LikesScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        AddOffer.routeName: (context) => AddOffer(),
        SignIn.routeName: (context) => const SignIn(),
        OtpPage.routeName: (context) => OtpPage(),
      },
    );
  }
}
