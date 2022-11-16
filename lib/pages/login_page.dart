import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/controller_pages.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/service/service_user_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Controller controller =  Controller();
 ServiceLoginUser login = ServiceLoginUser();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
           backgroundColor: const Color.fromARGB(254, 30, 50, 75),
      appBar: AppBar(
        title: const Text("Login"),
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.width * 0.2, left: size.width *0.09, right: size.width* 0.09),
              child: Image(
            image: const AssetImage('assets/images/mapa.png'),
            width: size.width * 0.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.04, right: size.width * 0.1, top: size.width * 0.2),
            child: TextFormField(
              controller: controller.email,
              style: const TextStyle(color: Colors.white54),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.email_outlined, color: Colors.white54,
                ),
                hintText: "Digite seu Email",
                labelText: "Email",
                hintStyle: TextStyle(color: Colors.white54),
                labelStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                )
              ),
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "Digite um email valido";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.04, right: size.width * 0.1),
            child: TextFormField(
              style: const TextStyle(color: Colors.white54),
              obscureText: controller.hiddenPassword,
              controller: controller.password,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.vpn_key_outlined, color: Colors.white54,
                ),
                hintText: "Digite sua Senha", 
                labelText: "Senha",
                hintStyle: const TextStyle(color: Colors.white54),
                labelStyle:  const TextStyle(color: Colors.white54),
                enabledBorder:  const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                ),
                suffixIcon: GestureDetector(
                  child: Icon( controller.hiddenPassword == false
                  ? Icons.visibility_off
                  : Icons.visibility,
                  color: Colors.white54,),
                  onTap: (){
                    setState(() {
                      controller.hiddenPassword = !controller.hiddenPassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "Digite uma senha valida";
                }
                return null;
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: ElevatedButton(
              onPressed: () async {
               await controller.onLogin(context);
               controller.clearlogin();
              },
              child:  const Text('Login'),
            ),
          )
        ]),
      ),
    );
  }
}
