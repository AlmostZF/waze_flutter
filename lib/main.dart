import 'package:flutter/material.dart';
import 'package:learning_dart/pages/initial_screen.dart';
import 'package:learning_dart/pages/poly_line_screen.dart';
import 'package:learning_dart/pages/tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), 
      initialRoute: '/',
      routes: {
        '/': (context) => TabBarScreen(),
        '/second': (context) =>  InitialScreen(),
        '/third': (context) => PolylineScreen()
      },
    );
  }
}
