// To parse this JSON data, do
//
//     final branch = branchFromJson(jsonString);

import 'dart:convert';

List<Branch> branchFromJson(List<dynamic> obj) =>
    List<Branch>.from(obj.map((x) => Branch.fromJson(x)));

String branchToJson(List<Branch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Branch {
  final String branchId;
  final String branchName;
  final String branchAddress;
  final String branchPhone;
  final int isStock;
  final int isTransaction;
  final dynamic ledgerId;

  Branch({
    required this.branchId,
    required this.branchName,
    required this.branchAddress,
    required this.branchPhone,
    required this.isStock,
    required this.isTransaction,
    required this.ledgerId,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        branchAddress: json["branch_address"],
        branchPhone: json["branch_phone"],
        isStock: json["is_stock"],
        isTransaction: json["is_transaction"],
        ledgerId: json["ledger_id"],
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "branch_name": branchName,
        "branch_address": branchAddress,
        "branch_phone": branchPhone,
        "is_stock": isStock,
        "is_transaction": isTransaction,
        "ledger_id": ledgerId,
      };
}
