import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sonar/screens/more_info/content/second_step.dart';

class PersonalInfo with ChangeNotifier {
  final Box _db = Hive.box('appDB');

  String name = "";
  String phoneNumber = "";
  String email = "";
  String age = "";
  String title = "";
  String city = "";
  bool genderIsNull = false;
  bool? isMale;
  bool isLoggedIN = false;
  String educational = "";
  bool educationalIsNull = false;
  String employmentState = "";
  bool employmentStateIsNull = false;
  List<int> favoriteCompaniesIndex = [];
  String userID = "";

  addBasicData({required String name, required String phoneNumber, required String email}) async {
    this.name = name;
    this.phoneNumber = phoneNumber;
    this.email = email;

    notifyListeners();
  }

  laudData() async {
    var userInfo = await _db.get("userInfo");
    if (userInfo != null) {
      name = userInfo["name"];
      phoneNumber = userInfo["phoneNumber"];
      email = userInfo["email"];
      city = userInfo["city"];
      favoriteCompaniesIndex = userInfo["Companies"];
      userID = userInfo["userID"];
      isLoggedIN = true;
    }
    notifyListeners();
  }

  saveUserInfo() async {
    await _db.put("userInfo", {
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "age": age,
      "title": title,
      "city": city,
      "isMale": isMale,
      "educational": educational,
      "employmentState": employmentState,
      "Companies": favoriteCompaniesIndex,
      "userID": ((DateTime.now().microsecond + DateTime.now().microsecond) / DateTime.now().millisecond).toString(),
    });
  }

  choseGender({required bool isMale}) {
    this.isMale = isMale;
    notifyListeners();
  }

  isGenderNull(bool isNull) {
    genderIsNull = isNull;
    notifyListeners();
  }

  secondStepChoicesNull(bool educationalIsNull, bool employmentStateIsNull) {
    if (educationalIsNull && employmentStateIsNull) {
      this.educationalIsNull = educationalIsNull;
      this.employmentStateIsNull = employmentStateIsNull;
    } else if (employmentStateIsNull) {
      this.educationalIsNull = educationalIsNull;
    } else {
      this.employmentStateIsNull = employmentStateIsNull;
    }
    notifyListeners();
  }

  addToFavoriteCompanies(int index) {
    favoriteCompaniesIndex.add(index);
    notifyListeners();
  }
}
