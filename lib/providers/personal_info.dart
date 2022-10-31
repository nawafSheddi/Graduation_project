import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersonalInfo with ChangeNotifier {
  late Box<dynamic> _db;
  String educational = "";
  String employmentState = "";

  PersonalInfo(Box<dynamic> db) {
    _db = db;
  }
}
