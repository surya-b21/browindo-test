part of 'employee_cubit.dart';

@immutable
abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeFound extends EmployeeState {
  final List<Employee> data;

  EmployeeFound({required this.data});
}

class EmployeeNotFound extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}
