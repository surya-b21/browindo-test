// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_flreelance/model/employee.dart';
import 'package:test_flreelance/services/employee_services.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final _employee = EmployeeServices();

  EmployeeCubit() : super(EmployeeInitial());

  Future<void> getListEmployee(
      {String branch = "", int departement = 0}) async {
    emit(EmployeeLoading());
    try {
      List<Employee> data =
          await _employee.getListEmployee(branch, departement);

      emit(EmployeeFound(data: data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> addEmployee(Employee employee) async {
    try {
      String message = await _employee.addEmployee(employee);

      if (message == "Tambah karyawan berhasil") {
        return message;
      } else {
        return "Gagal";
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
