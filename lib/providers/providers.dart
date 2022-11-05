import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sonar/providers/navBar_provider.dart';
import 'package:sonar/providers/offers_provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';
import 'package:sonar/providers/user_data_provider.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider<PersonalInfo>(
      create: (context) => PersonalInfo(),
    ),
    ChangeNotifierProvider<NavBarProvider>(
      create: (context) => NavBarProvider(),
    ),
    ChangeNotifierProvider<UserDataProvider>(
      create: (context) => UserDataProvider(),
    ),
    ChangeNotifierProvider<OffersProvider>(
      create: (context) => OffersProvider(),
    ),
    ChangeNotifierProvider<TrackingProvider>(
      create: (context) => TrackingProvider(),
    ),
  ];
}
