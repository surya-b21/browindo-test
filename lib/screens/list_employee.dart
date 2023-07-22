// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flreelance/bloc/auth/auth_bloc.dart';
import 'package:test_flreelance/cubit/branch/branch_cubit.dart';
import 'package:test_flreelance/cubit/departement/departement_cubit.dart';
import 'package:test_flreelance/cubit/employee/employee_cubit.dart';
import 'package:test_flreelance/screens/form_employee.dart';

class ListEmployee extends StatefulWidget {
  const ListEmployee({super.key});

  @override
  State<ListEmployee> createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  int departement = 0;
  String branch = "";
  @override
  void initState() {
    callBranch();
    callDepartement();
    callEmployee();
    super.initState();
  }

  void callBranch() async {
    await context.read<BranchCubit>().getBranch();
  }

  void callDepartement() async {
    await context.read<DepartementCubit>().getDepartement();
  }

  void callEmployee() async {
    await context.read<EmployeeCubit>().getListEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Employee"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(Logout());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<BranchCubit, BranchState>(
                  builder: (context, state) {
                    if (state is BranchFound) {
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              value: state.data.first.branchId,
                              onChanged: (String? value) {
                                setState(() {
                                  branch = value!;
                                });
                              },
                              items: state.data
                                  .map((e) => DropdownMenuItem(
                                        value: e.branchId,
                                        child: Text(
                                          e.branchName,
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ))
                                  .toList(),
                            )),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                BlocBuilder<DepartementCubit, DepartementState>(
                  builder: (context, state) {
                    if (state is DepartementFound) {
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              value: state.data.first.departmentId,
                              onChanged: (int? value) {
                                departement = value!;
                              },
                              items: state.data
                                  .map((e) => DropdownMenuItem(
                                        value: e.departmentId,
                                        child: Text(
                                          e.departmentName,
                                        ),
                                      ))
                                  .toList(),
                            )),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade300),
                    onPressed: () {
                      context.read<EmployeeCubit>().getListEmployee(
                          branch: branch, departement: departement);
                    },
                    child: const Text(
                      "Cari",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<EmployeeCubit, EmployeeState>(
              builder: (context, state) {
                if (state is EmployeeFound) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text(state.data[index].employeeName),
                          subtitle: Text(state.data[index].employeeMail),
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Detail Info"),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      "Nama : ${state.data[index].employeeName}"),
                                  Text(
                                      "Alamat : ${state.data[index].employeeAddress}"),
                                  Text(
                                      "Tanggal lahir : ${state.data[index].employeeDob}"),
                                  Text(
                                      "Email : ${state.data[index].employeeMail}"),
                                  Text(
                                      "Branch : ${state.data[index].branchName}"),
                                  Text(
                                      "Department : ${state.data[index].departmentName}"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Tutup'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(providers: [
                BlocProvider<DepartementCubit>(
                  create: (context) => DepartementCubit(),
                ),
                BlocProvider<BranchCubit>(
                  create: (context) => BranchCubit(),
                ),
                BlocProvider<EmployeeCubit>(
                  create: (context) => EmployeeCubit(),
                )
              ], child: const FormEmployee(title: "Tambah Employee")),
            ),
          );

          setState(() {
            callEmployee();
          });
        },
        tooltip: 'Tambah Employee',
        backgroundColor: Colors.blue.shade300,
        child: const Icon(Icons.add),
      ),
    );
  }
}
