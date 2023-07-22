// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_flreelance/cubit/branch/branch_cubit.dart';
import 'package:test_flreelance/cubit/departement/departement_cubit.dart';
import 'package:test_flreelance/cubit/employee/employee_cubit.dart';
import 'package:test_flreelance/model/employee.dart';

class FormEmployee extends StatefulWidget {
  final String title;
  const FormEmployee({super.key, required this.title});

  @override
  State<FormEmployee> createState() => _FormEmployeeState();
}

class _FormEmployeeState extends State<FormEmployee> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _alamatController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  String branch = "";
  int department = 0;

  @override
  void initState() {
    callBranch();
    callDepartement();
    super.initState();
  }

  void callBranch() async {
    await context.read<BranchCubit>().getBranch();
  }

  void callDepartement() async {
    await context.read<DepartementCubit>().getDepartement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan nama",
                      hintStyle: TextStyle(color: Colors.black38),
                      labelText: "Nama",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _alamatController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan alamat",
                      hintStyle: TextStyle(color: Colors.black38),
                      labelText: "Alamat",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: "Masukkan email",
                      hintStyle: TextStyle(color: Colors.black38),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            1970), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        _dateController.text =
                            formattedDate; //set foratted date to TextField value.
                      });
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: "Masukkan tanggal lahir",
                      hintStyle: TextStyle(color: Colors.black38),
                      labelText: "Tanggal lahir",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<BranchCubit, BranchState>(
                  builder: (context, state) {
                    if (state is BranchFound) {
                      return InputDecorator(
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black38),
                            labelText: "Branch",
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
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
                                    ),
                                  ))
                              .toList(),
                        )),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<DepartementCubit, DepartementState>(
                  builder: (context, state) {
                    if (state is DepartementFound) {
                      return InputDecorator(
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black38),
                            labelText: "Department",
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          value: state.data.first.departmentId,
                          onChanged: (int? value) {
                            department = value!;
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
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade300),
                    onPressed: () async {
                      Employee employee = Employee(
                        employeeName: _nameController.text,
                        employeeAddress: _alamatController.text,
                        employeeDob: DateTime.parse(_dateController.text),
                        employeeMail: _emailController.text,
                        departmentId: department,
                        branchId: branch,
                      );

                      String message = await context
                          .read<EmployeeCubit>()
                          .addEmployee(employee);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message)));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
