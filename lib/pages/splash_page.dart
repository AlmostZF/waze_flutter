import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/controller_authentication.dart';
import 'package:flutter_application_1/pages/autentication_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 4), 
      ()=> getRoute());
  }

   void getRoute() async {
    Navigator.pushReplacementNamed(context, await ControllerAuthentication().logedCheck());
  }
  

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return Scaffold(
            backgroundColor: Color.fromARGB(254, 30, 50, 75),
      body: SingleChildScrollView(
        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.height*0.1, top: size.height*0.35),
                child: SizedBox(
                  width: size.width *0.6,
                  height: size.width * 0.5,
                  child: const Image(
                    image: AssetImage('assets/images/mapa.png'))),
              )
            ],
          ),
      ),
    );
  }
}