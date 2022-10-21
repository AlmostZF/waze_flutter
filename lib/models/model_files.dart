class FilesModel {
  String? base64;
  String? ext; // extensão do arquivo
  String? fileName;
  String? mimetype;
  FilesModel({this.base64, this.ext, this.fileName, this.mimetype});
  FilesModel.fromJson(Map<String, dynamic> data) {
    base64 = data['base64'];
    ext = data['extension'];
    fileName = data['fileName'];
    mimetype = data['mimetype'];
  }

  Map sendToJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['extension'] = ext;
    data['name'] = fileName;
    data['mimetype'] = mimetype;
    data['base64'] = base64;
    return data;
  }
}
