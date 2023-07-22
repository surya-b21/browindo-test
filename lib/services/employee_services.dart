import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_flreelance/helper/dio_helper.dart';
import 'package:test_flreelance/model/employee.dart';

class EmployeeServices {
  final _http = DioHelper().initDio();
  final _storage = FlutterSecureStorage();

  Future<List<Employee>> getListEmployee(
      String branch, String departement) async {
    String url = "/employee/list?";
    if (branch.isNotEmpty) {
      url = "${url}branch_id=${branch}&";
    }

    if (departement.isNotEmpty) {
      url = "${url}departement=${departement}";
    }

    String? token = await _storage.read(key: 'token');

    final resp = await _http.get(
      url,
      options: Options(headers: {'token': token}),
    );

    return employeeFromJson(resp.data["data"]);
  }

  Future<String> addEmployee(Employee employee) async {
    String? token = await _storage.read(key: 'token');
    final resp = await _http.post(
      "/employee/add",
      data: employee.toJson(),
      options: Options(
        headers: {'token': token},
      ),
    );

    return resp.data["message"];
  }

  Future<String> editEmployee(Employee employee) async {
    String? token = await _storage.read(key: 'token');
    final resp = await _http.post(
      "/employee/edit",
      data: employee.toJson(),
      options: Options(
        headers: {'token': token},
      ),
    );

    return resp.data["message"];
  }

  Future<String> deleteEmployee(int employeeId) async {
    String? token = await _storage.read(key: 'token');
    final resp = await _http.post(
      "/employee/delete",
      options: Options(
        headers: {'token': token},
      ),
      data: jsonEncode({"employee_id": employeeId}),
    );

    return resp.data["message"];
  }
}
