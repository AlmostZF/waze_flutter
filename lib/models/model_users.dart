class UserModel {
  String? name;
  String? path;
  String? userId;
  String? id;
  UserModel({this.name, this.path, this.userId});
  UserModel.fromJson(Map data) {
    this.name = data ['name'];
    this.path = data ['path'];
    this.userId = data ['userId'];
    this.id = data ['id'];
  }

  Map toJson(){
    Map data = new Map ();
    data['name'] = this.name;
    data['path'] = this.path;
    data['userId'] = this.userId;
    data['id'] = this.id;
    return data;
  }
}