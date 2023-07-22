import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_flreelance/helper/dio_helper.dart';
import 'package:test_flreelance/model/branch.dart';
import 'package:test_flreelance/model/department.dart';

class ReferencesServices {
  final _http = DioHelper().initDio();
  final _storage = const FlutterSecureStorage();

  Future<List<Department>> getDepartementList() async {
    String? token = await _storage.read(key: 'token');
    final resp = await _http.get(
      "/department/list",
      options: Options(
        headers: {'token': token},
      ),
    );

    return departmentFromJson(resp.data["data"]);
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
