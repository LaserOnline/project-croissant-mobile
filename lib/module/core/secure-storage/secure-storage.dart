import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../model/token.model.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();
  Future<void> storeLoginData(GetToken loginData) async {
    await _storage.write(key: 'accessToken', value: loginData.accessToken);
    await _storage.write(key: 'refreshToken', value: loginData.refreshToken);
    print('accessToken ${loginData.accessToken}');
    print('refreshToken ${loginData.refreshToken}');
  }

  Future<void> clearTokenData() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
    print("clear token");
  }

  Future<Map<String, String?>> readTokenData() async {
    try {
      String? accessToken = await _storage.read(key: 'accessToken');
      String? refreshToken = await _storage.read(key: 'refreshToken');
      return {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
    } catch (e) {
      print('Error reading token data: $e');
      return {
        'accessToken': null,
        'refreshToken': null,
      };
    }
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  Future<void> saveAccessToken(String? accessToken) async {
    if (accessToken != null) {
      await _storage.write(key: 'accessToken', value: accessToken);
    }
  }

  Future<void> saveRefreshToken(String? refreshToken) async {
    if (refreshToken != null) {
      await _storage.write(key: 'refreshToken', value: refreshToken);
    }
  }

  Future<bool> hasTokens() async {
    String? accessToken = await _storage.read(key: 'accessToken');
    String? refreshToken = await _storage.read(key: 'refreshToken');
    print('Read Access Token: $accessToken');
    print('Read Refresh Token: $refreshToken');

    return accessToken != null && refreshToken != null;
  }
}
