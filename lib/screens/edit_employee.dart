// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_flreelance/model/employee.dart';
import 'package:test_flreelance/screens/form_employee.dart';

import '../cubit/employee/employee_cubit.dart';

class EditEmployee extends StatefulWidget {
  final Employee employee;
  const EditEmployee({super.key, required this.employee});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  TextEditingController nameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String branch = "001";
  int department = 1;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.employee.employeeName);
    alamatController =
        TextEditingController(text: widget.employee.employeeAddress);
    dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.employee.employeeDob));
    emailController = TextEditingController(text: widget.employee.employeeMail);
    super.initState();
  }

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

                  String message = await context
                      .read<EmployeeCubit>()
                      .editEmployee(employee);
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
