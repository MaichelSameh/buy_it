import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'services/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Auth()..autoLogin(),
      builder: (ctx, child) => MaterialApp(
        initialRoute: ctx.watch<Auth>().isAuth
            ? HomeScreen.route_name
            : LoginScreen.route_name,
        routes: {
          LoginScreen.route_name: (_) => LoginScreen(),
          SignUpScreen.route_name: (_) => SignUpScreen(),
          HomeScreen.route_name: (_) => HomeScreen(),
        },
      ),
    );
  }
}
