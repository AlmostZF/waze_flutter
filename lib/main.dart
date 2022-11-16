import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/autentication_page.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:flutter_application_1/pages/splash_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/splash_screen',
      //'/authentication',
      routes: {
        '/login_page': (context) => LoginScreen(),
        '/splash_screen': (context) => SplashScreen(),
        '/authentication': (context) => AuthenticationScreen(),
        '/register_screen': (context) => RegisterScreen(),
         '/home_page':(context) => HomePage(),  
      }
    );
  }
}
