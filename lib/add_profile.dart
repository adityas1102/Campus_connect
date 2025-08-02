import 'package:campus_connect/data_base/data_base_sql.dart';
import 'package:campus_connect/model/student.dart';
import 'package:flutter/material.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _departmentController = TextEditingController();

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final newStudent = Student(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        department: _departmentController.text,
      );
      await DataBaseSql.insertStudent(newStudent);
      Navigator.pop(context);
    }
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:Form(
        key: _formKey,
        child: Column(
          children: [
            const Icon(Icons.person, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: _buildInputDecoration('Name'),
              validator: (value) => value!.isEmpty ? 'Enter name' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ageController,
              decoration: _buildInputDecoration('Age'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter age' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _departmentController,
              decoration: _buildInputDecoration('Department'),
              validator: (value) => value!.isEmpty ? 'Enter department' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Submit'),
            )
          ],
        ),
      ),

    ),
    );
  }
}
