import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:last/pages/login_page.dart';
import 'package:last/pages/home_page.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  loginState() async {
    final storage = FlutterSecureStorage();
    String? _userID = await storage.read(key: "userID");
  }

  final String? _userID = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BarberShop',
      home: SplashScreen(),
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
    final storage = FlutterSecureStorage();
    String? _userID = await storage.read(key: "userID");
  }

  final String? _userID = "";

  @override
  void initState() {
    _startApp();

    super.initState();
  }

  Future<void> _startApp() async {
    final storage = FlutterSecureStorage();
    String? userID = await storage.read(key: "userID");
    if (userID == null) {
      await Navigator.push(
          context, MaterialPageRoute(builder: (_) => LoginDemo()));
    } else {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomePage(
                    userID: userID,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Загрузка..."),
      ),
    );
  }
}
