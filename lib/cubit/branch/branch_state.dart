part of 'branch_cubit.dart';

@immutable
abstract class BranchState {}

class BranchInitial extends BranchState {}

class BranchFound extends BranchState {
  final List<Branch> data;

  BranchFound({required this.data});
}

class BranchNotFound extends BranchState {}

class BranchLoading extends BranchState {}
