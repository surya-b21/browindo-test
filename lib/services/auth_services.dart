import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_flreelance/helper/dio_helper.dart';

class UserServices {
  final _storage = FlutterSecureStorage();
  final _http = DioHelper().initDio();

  Future<String> login(String user_id, String password) async {
    var bytes = utf8.encode(password);
    var hashed = sha256.convert(bytes);
    final resp = await _http.post("/login",
        data: json.encode(
          {"user_id": user_id, "user_password": hashed},
        ),
        options: Options(responseType: ResponseType.json));

    await _storage.write(key: "token", value: resp.data["token"]);
    await _storage.write(key: "refresh", value: resp.data["refresh"]);

    return resp.data['message'];
  }
}
