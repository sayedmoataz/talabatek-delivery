import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{
  static SharedPreferences? sharedPreferences ;
  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future saveBoolData({required key,required value})async {
    return sharedPreferences!.setBool(key, value);
  }
  static Future saveIntData({required key,required value})async {
    return sharedPreferences!.setInt(key, value);
  }
  static Future saveStringData({required key,required value})async {
    return sharedPreferences!.setString(key, value);
  }

  static Future saveListStringData({required key,required value})async {
    return sharedPreferences!.setStringList(key, value);
  }
  static getData({required key}){
    return sharedPreferences!.get(key);
  }
  static getListData({required key}){
    return sharedPreferences!.getStringList(key);
  }
}