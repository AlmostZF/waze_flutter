import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/service_user_login.dart';
import 'package:flutter_application_1/utils/save_token.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ControllerAuthentication {
  // variaveis
  VoidCallback? updateState;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // services
  ServiceLoginUser serviceLoginUser = ServiceLoginUser();

  // actions
    Future<String> logedCheck() async {
    if (await SaveToken?.getTokens('token') != null ) {
      return '/home_page';
      
    } else {
      return '/authentication';
    }
  }

  Future<void> loginUser() async {
    Map data = Map();
    data['email'] = email.text;
    data['password'] = password.text;
    await serviceLoginUser.loginUser(data).then((resultLogin) async {
      if (resultLogin != null) {
        await SaveToken?.saveTokens('token', resultLogin.data['DATA']
          ['userLoged']['user']['stsTokenManager']['accessToken'].toString());
        await SaveToken?.saveTokens('refresh_token', resultLogin.data['DATA']
          ['userLoged']['user']['stsTokenManager']['refreshToken'].toString());
          
      } else {
        print('Login incorreto!');
      }
    }).catchError((e) => print(e));
  }

}
