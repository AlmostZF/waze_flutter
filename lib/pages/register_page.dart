import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/controller/controller_pages.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return Scaffold(
            backgroundColor: Color.fromARGB(254, 30, 50, 75),
      appBar: AppBar(
        title: const Text("Registrar"),
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: size.height*0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width*0.92,
              child: TextFormField(
                style: const TextStyle(color: Colors.white54),
                controller: controller.displayName,
                decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle, color: Colors.white54),
                    hintText: "Digite seu nome",
                    labelText: "Nome",
                    hintStyle: TextStyle(color: Colors.white54),
                    labelStyle: TextStyle(color: Colors.white54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    )
                ),
              ),
            ),
            SizedBox(
              width: size.width*0.92,
              child: TextFormField(
                style: const TextStyle(color: Colors.white54),
                controller: controller.email,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email_outlined, color: Colors.white54),
                    hintText: "Digite seu Email",
                    labelText: "Email",
                    hintStyle: TextStyle(color: Colors.white54),
                    labelStyle: TextStyle(color: Colors.white54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    )
                ),
              ),
            ),
            SizedBox(
              width: size.width*0.92,
              child: TextFormField(
                style: const TextStyle(color: Colors.white54),
                obscureText: controller.hiddenPassword,
                controller: controller.password,
                decoration: InputDecoration(
                  fillColor: Colors.white54,
                    icon: Icon(Icons.vpn_key_sharp, color: Colors.white54),
                    hintText: "Digite sua Senha",
                    labelText: "Senha",
                    hintStyle: TextStyle(color: Colors.white54),
                    labelStyle: TextStyle(color: Colors.white54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    
                  suffixIcon: GestureDetector(
                  child: Icon( controller.hiddenPassword == false
                  ? Icons.visibility_off
                  : Icons.visibility,
                  color: Colors.white54,),
                  onTap: () {
                    setState(() {
                      controller.hiddenPassword = !controller.hiddenPassword;
                    });
                  },
                ),
                ),
              ),
            ),
            SizedBox(
              width: size.width*0.92,
              child: TextFormField(
                style: const TextStyle(color: Colors.white54),
                obscureText: controller.hiddenPassword,
                controller: controller.confirmedPassword,
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key_sharp, color: Colors.white54),
                    hintText: "Confirme sua senha",
                    labelText: "Confirmação de senha", 
                    hintStyle: TextStyle(color: Colors.white54),
                    labelStyle: TextStyle(color: Colors.white54),
                    enabledBorder: UnderlineInputBorder(
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.02),
                  child: IconButton(
                    onPressed: () async{
                      await controller.getImage(ImageSource.gallery);
                      setState(() {
                        
                      });
                    },
                    icon: const Icon(Icons.image, color: Colors.white54,),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.02),
                  child: IconButton(
                    onPressed: () async {
                    await controller.getImage(ImageSource.camera);
                      setState(() {
                        
                      });
                    },
                    icon: Icon(Icons.camera_alt, color: Colors.white54,),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: size.height*0.02)),
            Container(
               width: size.width*0.6,
               height: size.height*0.3,
              
              child: controller.file == null

              ? Center(
                child: Text('Selecione uma foto') ,
              )
              : controller.loading
              ? Container(
    
                child: CircularProgressIndicator(),
              )
              : ClipOval(child: Image.file(File(controller.file!.path),width: 200, height: 200, fit: BoxFit.cover,)),
                ),
                Padding(padding: EdgeInsets.only(top: size.height*0.03)),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  controller.loading = true;
                });
                
                if (controller.password.text ==
                            controller.confirmedPassword.text) {
                          setState(() {
                            controller.loading = true;
                          });
                          await controller.buildContextBody(context);
                          controller.clearRegister();
                          setState(() {
                            controller.loading = false;
                          });
                        } else {
                          Fluttertoast.showToast(msg: "Digite senhas iguais",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP_RIGHT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.teal,
                          textColor: Colors.white,
                          fontSize: 16.0);
                        }

                setState(() {
                  controller.loading = false;
                });
              },
              child: const Text('Registar-se'),
            ),
          ],
        ),
      ),
    );
  }
}
