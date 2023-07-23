// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flreelance/screens/form_employee.dart';

import '../cubit/employee/employee_cubit.dart';
import '../model/employee.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final nameController = TextEditingController();
  final alamatController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  String branch = "001";
  int department = 1;

  void updateBranch(String newBranch) {
    setState(() {
      branch = newBranch;
    });
  }

  void updateDepartment(int newDepartment) {
    setState(() {
      department = newDepartment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Employee"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      body: Center(
        child: Column(
          children: [
            FormEmployee(
              nameController: nameController,
              alamatController: alamatController,
              dateController: dateController,
              emailController: emailController,
              updateBranch: updateBranch,
              updateDepartment: updateDepartment,
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
                    employeeName: nameController.text,
                    employeeAddress: alamatController.text,
                    employeeDob: DateTime.parse(dateController.text),
                    employeeMail: emailController.text,
                    departmentId: department,
                    branchId: branch,
                  );

                  String message =
                      await context.read<EmployeeCubit>().addEmployee(employee);
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
    );
  }
}
