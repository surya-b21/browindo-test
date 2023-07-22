// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_flreelance/model/department.dart';
import 'package:test_flreelance/services/references_services.dart';

part 'departement_state.dart';

class DepartementCubit extends Cubit<DepartementState> {
  final _ref = ReferencesServices();

  DepartementCubit() : super(DepartementInitial());

  Future<void> getDepartement() async {
    emit(DepartementLoading());
    try {
      List<Department> data = await _ref.getDepartementList();
      if (data.isNotEmpty) {
        emit(DepartementFound(data: data));
      } else {
        emit(DepartementNotFound());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
