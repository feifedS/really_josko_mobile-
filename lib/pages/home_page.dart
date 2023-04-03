import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:last/controllers/request_controller.dart';
import 'package:last/pages/profile_page.dart';
import 'package:last/pages/service_page.dart';
import 'package:last/services/storage_service.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'login_page.dart';
import 'register_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// import 'package:covid_communiquer/repository/chat_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({required String userID});
  @override
  _HomePageState createState() => _HomePageState();

  final RequestController _requestController = RequestController();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  final StorageService _storageService = StorageService();
  String? _userID = "";

  @override
  void initState() {
    super.initState();
    getUserID().then((String? userID) {
      setState(() => {_userID = userID.toString()});
    });
  }

  Future<String?> getUserID() async {
    _userID = await _storageService.readSecureData("userID");
    // print("TTTTTTTTTTTT: ${_userID.first.key}: ${_userID.first.value}");
    return _userID;
  }

  int currentPage = 0;
  List<Widget> pages = [
    HomePage(
      userID: "",
    ),
    ProfilePage()
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 28, 255),
        title: const Text('BarberShop'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginDemo()));
                _storageService.deleteAllSecureData();
              },
              child: const Text('Выйти'))
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Text('Добро пожаловать ${_userID}'),
          TextButton(
            onPressed: () {
              widget._requestController.getTypeOfService(
                  StorageService().readSecureData("token").toString());
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ServicePage()));
            },
            child: Text(
              'Заказать услугу',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ]),
      ),
    );
  }
}
