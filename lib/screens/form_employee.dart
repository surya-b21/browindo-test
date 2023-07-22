import 'package:flutter/material.dart';

class FormEmployee extends StatefulWidget {
  final String title;
  const FormEmployee({super.key, required this.title});

  @override
  State<FormEmployee> createState() => _FormEmployeeState();
}

class _FormEmployeeState extends State<FormEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
