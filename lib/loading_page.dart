// import 'package:flutter/material.dart';
// import 'package:last/services/storage_service.dart';

// import 'HomePage.dart';
// import 'login.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isLoading = false;
//   String? _userID = "";
//   final StorageService _storageService = StorageService();
//   Widget widgetName = HomePage();

//   Future<String?> getUserID() async {
//       _userID = await _storageService.readSecureData("userID");
//       // print("TTTTTTTTTTTT: ${_userID.first.key}: ${_userID.first.value}");
//       return _userID;
//   }

//   @override
//   void initState() {
//     super.initState();

//     // @override
//     // Widget build(BuildContext context) {
//     //   getUserID().then((String? userID) {
//     //     _userID = userID;
//     //   });

//     //   return FutureBuilder(
//     //       future: getUserID(),
//     //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//     //         if (_userID == null) {
//     //           widgetName = LoginDemo();
//     //         }
//     //         return MaterialApp(home: widgetName);
//     //       });
//     // }

//   // @override
//   //   Widget build(BuildContext context) {
//   //     getUserID().then((String? userID) {
//   //       _userID = userID;
//   //     });

//   //     return MaterialApp(
//   //       home: Scaffold(
//   //           body: _isLoading
//   //               ? CircularProgressIndicator() // this will show when loading is true
//   //               : Text(
//   //                   'You widget tree after loading ...') // this will show when loading is false
//   //           ),
//   //     );
//   //   }
//   // }
//   }
//   @override
//   Widget build(BuildContext context) {
//     getUserID().then((String? userID) {
//       _userID = userID;
//     });

//     return FutureBuilder(
//       future: getUserID(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (_userID == null) {
//           widgetName = LoginDemo();
//         }
//         return MaterialApp(home: widgetName);
//       }
//     );
//   }
// }
