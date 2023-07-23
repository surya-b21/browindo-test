// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'dart:convert';

List<Department> departmentFromJson(List<dynamic> obj) =>
    List<Department>.from(obj.map((x) => Department.fromJson(x)));

String departmentToJson(List<Department> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Department {
  final int departmentId;
  final String departmentName;

  Department({
    required this.departmentId,
    required this.departmentName,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        departmentId: json["department_id"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "department_id": departmentId,
        "department_name": departmentName,
      };
}
