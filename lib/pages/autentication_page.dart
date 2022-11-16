import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/controller_pages.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/register_page.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  Controller controller = Controller();

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(254, 30, 50, 75),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.width * 0.4),
              child: Center(
                  child: Image(
                  image: const AssetImage('assets/images/mapa.png'),
                  width: size.width * 0.5,
                )
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:size.width *0.5),
                  child: SizedBox(
                    width: size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()
                    ),);},
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: size.width * .05,),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:size.width *0.01),
                  child: SizedBox(
                    width: size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: Text(
                        'Registrar',
                        style: TextStyle(fontSize: size.width * .05),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
