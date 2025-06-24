import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class TokenService {
static const _storage = FlutterSecureStorage();
static const _key = 'jwt_token';

//save
static Future<void>   saveToken (String Token) async{
  await _storage.write(key: _key, value: Token);
}

static Future<String?> getToken()async{
  return await _storage.read(key: _key);
}

///delete
static Future<void> deleteToken() async {
   await _storage.delete(key: _key);
}
}