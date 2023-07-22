import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_flreelance/helper/dio_helper.dart';
import 'package:test_flreelance/model/branch.dart';

class ReferencesServices {
  final _http = DioHelper().initDio();
  final _storage = FlutterSecureStorage();

  Future<List<Map<String, dynamic>>> getDepartementList() async {
    String? token = await _storage.read(key: 'token');
    final resp = await _http.get(
      "/departement/list",
      options: Options(
        headers: {'token': token},
      ),
    );

    return resp.data["data"];
  }

  Future<List<Branch>> getBranchList() async {
    String? token = await _storage.read(key: 'token');
    final resp = await _http.get(
      "/branch/list",
      options: Options(
        headers: {'token': token},
      ),
    );

    return branchFromJson(resp.data["data"]);
  }
}
