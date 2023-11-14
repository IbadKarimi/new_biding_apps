
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefresnces {
  SharedPreferences prefs;

  void setFullName(String fullName) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("fullName", fullName);
  }

  Future<String> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString("fullName") ?? ""; // Provide a default value if "fullName" is not found
    return fullName;
  }

}