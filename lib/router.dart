import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'HomePage.dart';
import 'login.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: "home",
      path: "/",
      builder: (BuildContext context, GoRouterState state) => HomePage(
        userID: "",
      ),
      routes: const [],
    ),
    GoRoute(
      // name: "login",
      path: "/login",
      builder: (BuildContext context, GoRouterState state) {
        return LoginDemo();
      },
    ),
  ],
);
