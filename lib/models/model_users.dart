
class UserModel {
  String? email;
  String? password;
  String? displayName;
  String? photoUrl;
  UserModel({this.email, this.password, this.displayName, this.photoUrl});
  UserModel.fromJson(Map data) {
    displayName = data['displayName'];
    email = data['email'];
    password = data['password'];
    photoUrl = data['photoUrl'];
  }
  Map sendToJson() {
    Map data= Map();
    data['displayName'] = displayName;
    data['email'] = email;
    data['password'] = password;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
