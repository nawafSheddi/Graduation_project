import 'package:cloud_firestore/cloud_firestore.dart';
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

  addMoreInfo({required String age, required String title, required String city}) async {
    this.age = age;
    this.title = title;
    this.city = city;

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

  saveUserInfo(Map? data) async {
    print("Sign in 1");
    if (data == null) {
      print("Sign in 2");
      userID = ((DateTime.now().microsecond + DateTime.now().microsecond) / DateTime.now().millisecond).toString();
      Map<String, dynamic> allUserData = {
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
        "userID": userID,
      };
      await _db.put("userInfo", allUserData);

      FirebaseFirestore.instance.collection("Users").doc(allUserData["userID"]).set(allUserData);
    } else {
      print("Sign in 3");
      name = data["name"];
      phoneNumber = data["phoneNumber"];
      userID = data["userID"];
      email = data["email"];
      print(data["userID"]);
      print(userID);
      await _db.put("userInfo", {
        "name": data["name"],
        "phoneNumber": data["phoneNumber"],
        "email": data["email"],
        "age": age,
        "title": title,
        "city": city,
        "isMale": isMale,
        "educational": educational,
        "employmentState": employmentState,
        "Companies": favoriteCompaniesIndex,
        "userID": data["userID"],
      });
      print("Sign in 4");
    }
  }

  Future<bool> checkIsRegister(String phoneNumber) async {
    bool isRegister = false;
    await FirebaseFirestore.instance.collection("Users").get().then((querySnapshot) => {
          querySnapshot.docs.forEach((doc) => {
                if (doc.data()["phoneNumber"] == phoneNumber) {isRegister = true, saveUserInfo(doc.data())},
              })
        });
    return isRegister;
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
