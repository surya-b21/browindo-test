part of 'departement_cubit.dart';

@immutable
abstract class DepartementState {}

class DepartementInitial extends DepartementState {}

class DepartementFound extends DepartementState {
  final List<Department> data;

  DepartementFound({required this.data});
}

class DepartementNotFound extends DepartementState {}

class DepartementLoading extends DepartementState {}
