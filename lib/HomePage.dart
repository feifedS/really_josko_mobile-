import 'package:flutter/material.dart';
import 'package:last/profile_page.dart';
import 'package:last/services/storage_service.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'login.dart';
import 'register.dart';

import 'package:last/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// import 'package:covid_communiquer/repository/chat_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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
  List<Widget> pages = [HomePage(), ProfilePage()];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 28, 255),
        title: const Text('BarberShop'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginDemo();
                    },
                  ),
                );
                // BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
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
      body: Container(
        child: Text('Добро пожаловать ${_userID}'), // ${widget.username}
      ),
      // body: SingleChildScrollView(
      //     child: Column(
      //   children: <Widget>[
      //     // FutureBuilder(
      //     //   future: FlutterSession().get('token'),
      //     //   builder: (context, snapshot) {
      //     //   return Text(snapshot.hasData ? snapshot.data : 'Loading...');
      //     // }),
      //     // ignore: avoid_unnecessary_containers
      //     Container(
      //       child:
      //           Text('Добро пожаловать ${widget.name}'), // ${widget.username}
      //     ),
      //     Container(
      //       margin: const EdgeInsets.only(right: 20.0, left: 35.0, top: 20),
      //       height: 80,
      //       width: 150,
      //       child: ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (_) => LoginDemo()));
      //         },
      //         child: const Text(
      //           'Вход',
      //           style: TextStyle(color: Colors.white, fontSize: 18),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       height: 80,
      //       width: 150,
      //       margin: const EdgeInsets.only(left: 20.0, top: 20),
      //       child: ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (_) => RegisterPage()));
      //         },
      //         child: const Text(
      //           'Регистрация',
      //           style: TextStyle(color: Colors.white, fontSize: 18),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       height: 80,
      //       width: 150,
      //       margin: const EdgeInsets.only(left: 20.0, top: 20),
      //       child: ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (_) => RegisterPage()));
      //         },
      //         child: const Text(
      //           'Выйти',
      //           style: TextStyle(color: Colors.white, fontSize: 18),
      //         ),
      //       ),
      //     )
      //   ],
      // )),
    );
  }
}
