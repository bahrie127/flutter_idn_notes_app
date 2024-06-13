import 'package:flutter_idn_notes_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_idn_notes_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', data.toJson());
  }

  Future<AuthResponseModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('auth_data');
    return AuthResponseModel.fromJson(data!);
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_data');
  }
}
