import 'package:shared_preferences/shared_preferences.dart';

class VendaService {
  final String baseUrl = 'http://127.0.0.1:8000/api'; 

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

}