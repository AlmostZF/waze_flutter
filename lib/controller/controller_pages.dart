

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model_files.dart';
import 'package:flutter_application_1/models/model_login.dart';
import 'package:flutter_application_1/models/model_users.dart';
import 'package:flutter_application_1/service/service_image.dart';
import 'package:flutter_application_1/service/service_user.dart';
import 'package:flutter_application_1/service/service_user_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class Controller{
  //variáveis
  XFile? file;
  ImageModel? imageModel;
  UserModel? userModel;
  VoidCallback? updateState;
  bool loading = false;
  bool hiddenPassword = true;
  ServiceImage serviceImage = ServiceImage();
  ServiceUser serviceUser = ServiceUser();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmedPassword = TextEditingController();
  TextEditingController displayName = TextEditingController();
  LoginModel? loginUser;
  List<UserModel> listUser = [];
  // services
   ServiceLoginUser serviceLoginUser = ServiceLoginUser();
 
  //actions 
  Future<void> getImage(ImageSource source) async {
    XFile? imageReq = await ImagePicker.platform.getImage(source: source);
    file = imageReq;
  }

  Future<String> convertImage() async {
    List<int> imageBytes = await file!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
  passwordVerification() {
    if (password != confirmedPassword){
        Fluttertoast.showToast(
        msg: "senhas nao sao iguais",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0
    );
    } else {
      print("senhas iguais");
    }
  }

  clearlogin(){
    email.clear();
    password.clear();
  }
  clearRegister(){
    email.clear();
    password.clear();
    confirmedPassword.clear();
    displayName.clear();
  }

  Future<void> buildContextBody(BuildContext context) async {
    List<String> param = file!.path.split('/');
    List<String> paramSufix = param.last.toString().split('.');
    String fileName = paramSufix.first;
    String ext = '.' + paramSufix.last;
    String mimetype = 'image/' + paramSufix.last;
    imageModel = ImageModel();
    Map<String, dynamic> data = {
      "base64": await convertImage(),
      "extension": ext,
      "fileName": fileName,
      "mimetype": mimetype
    };
    imageModel = ImageModel.fromJson(data);
    await serviceImage
        .registerImage(imageModel!.sendToJson())
        .then((value) async {
      if (value != null) {
        print(value['docfile']);
        String photoUrl = value['docfile'];
        userModel = UserModel();
        
        Map user = {
          "displayName": displayName.text,
          "email": email.text,
          "password": password.text.toString(),
          "photoUrl": photoUrl,
        };
        userModel = UserModel.fromJson(user);
        print(user);
        await serviceUser.registerUser(userModel!.sendToJson()).then((result) {
          print('Result');
          print(result);
        });
      } else {
        print('Erro');
      }
    });
  }
    onLogin(BuildContext context) async {
    loginUser = LoginModel();
    Map login = {
      "email": email.text,
      "password": password.text,
    };
    loginUser = LoginModel.fromJson(login);
    //print('Criou Map${loginUser}');
    await serviceLoginUser
        .loginUser(loginUser!.sendToJson())
        .then((loginResult) {

      print(loginResult);

      switch (loginResult) {
        case 200:
          Navigator.of(context).pushNamed('/home_page');
          break;
        default:

      }
    });
  }

}
