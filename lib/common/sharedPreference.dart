


import 'package:shared_preferences/shared_preferences.dart';

class GetUserDetail{
  Future<void>  setUserData(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }

  Future<String> getUserData(key)async{
    
    final prefs = await SharedPreferences.getInstance();
    String? text= prefs.getString(key);
    print("share pre ----------${key}---------------- $text");
    return text.toString() ;
  }
  remove(key)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
  Future<void>  setUserName(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }
  Future<void>  setUserphone(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }
  Future<void>  setUseremail(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }
}