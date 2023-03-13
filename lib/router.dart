import 'package:go_router/go_router.dart';

import 'HomePage.dart';
import 'login.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      name: "home",
      path: "/",
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          name: "login",
          path: "login",
          builder: (context, state) {
            return LoginDemo();
          },
        ),
      ],
    ),
  ],
);
