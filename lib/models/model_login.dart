class LoginModel {
 String? email;
  String? password;
  LoginModel({this.email, this.password});
  LoginModel.fromJson(Map data) {
    email = data['email'];
    password = data['password'];
  }
  
  Map sendToJson() {
    Map data = Map();
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}