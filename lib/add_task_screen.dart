import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String? _title = '';
  String? _priority = 'Low';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  final _formKey = GlobalKey<FormState>();

  _handleDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    if (date != _date) {
      setState(() {
        _date = date as DateTime;
      });
      _dateController.text = _dateFormat.format(date!);
    }
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                      onSaved: (input) => _title = input,
                      validator: (input) => input!.trim().isEmpty
                          ? 'Please enter task title'
                          : null,
                    ),
                    DropdownButtonFormField(
                      icon: Icon(Icons.arrow_drop_down),
                      items: _priorities.map((priority) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Text(
                            priority,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: "Priority"),
                      onSaved: (input) => _priority = input!,
                      onChanged: (value) {
                        setState(() {
                          _priority = value! as String;
                        });
                      },
                      value: _priority,
                      validator: (input) =>
                      _priority == null ? "Please select priority" : null,
                    ),
                    TextFormField(
                      controller: _dateController,
                      onTap: _handleDatePicker,
                      decoration: InputDecoration(
                        labelText: "Date",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _submit,
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}