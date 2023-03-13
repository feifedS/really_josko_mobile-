import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:last/services/storage_service.dart';
import 'HomePage.dart';
import 'login.dart';

void main() {
  String? _userID = "";
  Future<String?> getUserID() async {
    return _userID;
  }

  runApp(SplashScreen());

  getUserID().then((String? userID) {
    _userID = userID;
  });

  runApp(MyApp(userID: _userID));
}

class MyApp extends StatelessWidget {
  final String? userID;
  const MyApp({
    @required this.userID,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Widget widgetName = HomePage();

    if (userID == null) {
      widgetName = LoginDemo();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widgetName,
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen() : super();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loginState() async {
    if (await FlutterSecureStorage().read(key: "userID") != null) {
      isLoggedIn = true;
    }
  }

  bool isLoggedIn = false;
  var image;
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loginState(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return isLoggedIn
            ? Container(
                color: Colors.white,
              )
            : Container(
                color: Colors.white,
              );
      },
    );
  }
}
