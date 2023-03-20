import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:last/login.dart';
import 'HomePage.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
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
    // return FutureBuilder(
    //   // future: StorageService().readSecureData("userID"),
    //   future: loginState(),
    //   builder: (BuildContext context, AsyncSnapshot<String?> userID) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BarberShop',
      home: SplashScreen(),
      // home: (_userID != null) ? HomePage(userID: _userID,) : LoginPage(title: 'Авторизация')
    );
    // return userID != null
    // ?HomePage(userID: "asdasd",)
    // :LoginPage(title: "Авторизация");
    // });    // home: LoginPage(title: 'Геология страница'),
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
    // Timer(Duration(seconds: 2),
    //         ()=>Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder:
    //             (context) =>
    //             HomePage()
    //         )
    //     )
    // );
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
  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: loginState(),
  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       return _userID != null?HomePage(userID: snapshot.data)
  //       :LoginPage(title: "Авторизация");
  //   },);
  // }
}
// void main() {
//   // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   String? _userID = "";
//   Future<String?> getUserID() async {
//     return _userID;
//   }

//   runApp(SplashScreen());

//   getUserID().then((String? userID) {
//     _userID = userID;
//   });

//   runApp(MyApp(userID: _userID));
// }

// class MyApp extends StatelessWidget {
//   final String? userID;
//   const MyApp({
//     @required this.userID,
//   }) : super();

//   @override
//   Widget build(BuildContext context) {
//     // Widget widgetName = HomePage();
//     print("DDDDDDD${userID}");
//     if (userID == null) {
//       // widgetName = LoginDemo();
//       // context.go('/login');
//       print("Print 444444444444${userID}");
//     } else {
//       // context.go('/');
//       // print("Print 4445444${userID}");
//     }

//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       // home: widgetName,
//       routerConfig: router,
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   SplashScreen() : super();

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   loginState() async {
//     final storage = FlutterSecureStorage()
//     String? _userID = await storage.read(key: "uderID");
//     }
//   }
//   final String? _userID = ""
 
//   @override
//   void initState() {
//     getUserID();
//     super.initState();
//   }
//   //   Timer(
//   //       Duration(seconds: 10),
//   //       () => Navigator.pushReplacement(
//   //           context, MaterialPageRoute(builder: (context) => LoginDemo())));
//   // }
//   // void initState() {
//   //   super.initState();
//   //   getUserID().then((String? userID) {
//   //     setState(() => {_userID = userID.toString()});
//   //   });
//   // }

//   Future<void> getUserID() async {
//     String? _userID = await FlutterSecureStorage.read("userID");
//     print("Print66666666666666${_userID}");
//     if (_userID == null) {
//       context.pushReplacement("/login");
//     } else {
//       context.pushReplacement("/");
//     }
//     // print("TTTTTTTTTTTT: ${_userID.first.key}: ${_userID.first.value}");
//     return _userID;
//   }} 

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: loginState(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         print("Print 233333333333333");
//         return isLoggedIn
//             ? Container(
//                 color: Colors.white,
//               )
//             : Container(
//                 color: Colors.white,
//               );
//       },
//     );
//   }
// }
