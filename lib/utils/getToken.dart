import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    // Retrieve the JWT token
    String? token = await storage.read(key: 'token');
    return token;
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
