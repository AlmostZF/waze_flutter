import 'package:shared_preferences/shared_preferences.dart';

class SaveToken {

  //set Token
  static saveTokens(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  //get Token
  static getTokens(String key) async {
    final preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey(key)){
      return preferences.get(key).toString();
    }else{
      return null;
    }
  }

  //remove Token
  static removeAllTokens() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
