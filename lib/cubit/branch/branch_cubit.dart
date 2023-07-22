// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_flreelance/model/branch.dart';
import 'package:test_flreelance/services/references_services.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final _ref = ReferencesServices();
  BranchCubit() : super(BranchInitial());

  Future<void> getBranch() async {
    emit(BranchLoading());
    try {
      List<Branch> data = await _ref.getBranchList();

      if (data.isNotEmpty) {
        emit(BranchFound(data: data));
      } else {
        emit(BranchNotFound());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
