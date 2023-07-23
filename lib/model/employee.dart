// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

List<Employee> employeeFromJson(List<dynamic> obj) =>
    List<Employee>.from(obj.map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  int? employeeId;
  final String employeeName;
  final String employeeAddress;
  final DateTime employeeDob;
  final String employeeMail;
  final int departmentId;
  int? flagEmployee;
  final String branchId;
  String? branchName;
  String? departmentName;

  Employee({
    this.employeeId,
    required this.employeeName,
    required this.employeeAddress,
    required this.employeeDob,
    required this.employeeMail,
    required this.departmentId,
    this.flagEmployee,
    required this.branchId,
    this.branchName,
    this.departmentName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        employeeId: json["employee_id"],
        employeeName: json["employee_name"],
        employeeAddress: json["employee_address"],
        employeeDob: DateTime.parse(json["employee_dob"]),
        employeeMail: json["employee_mail"],
        departmentId: json["department_id"],
        flagEmployee: json["flag_employee"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "employee_name": employeeName,
        "employee_address": employeeAddress,
        "employee_dob":
            "${employeeDob.year.toString().padLeft(4, '0')}-${employeeDob.month.toString().padLeft(2, '0')}-${employeeDob.day.toString().padLeft(2, '0')}",
        "employee_mail": employeeMail,
        "department_id": departmentId,
        "flag_employee": flagEmployee,
        "branch_id": branchId,
        "branch_name": branchName,
        "department_name": departmentName,
      };
}
