import 'package:campus_connect/add_profile.dart';
import 'package:campus_connect/data_base/data_base_sql.dart';
import 'package:campus_connect/model/student.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  void fetchStudents() async {
    final data = await DataBaseSql.getStudents();
    setState(() {
      students = data;
    });
  }

  void _navigateToAddProfile() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProfile()),
    );
    fetchStudents();
  }

  void _viewProfile(Student student) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(student.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person, size: 60, color: Colors.grey),
            Text("Age: ${student.age}"),
            Text("Department: ${student.department}"),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'CampusConnect',
          style: TextStyle(
            fontWeight: FontWeight.w800,

          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(student.name),
              subtitle: Text(student.department),
              onTap: () => _viewProfile(student),
            );
          },
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _navigateToAddProfile,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),

            child: const Text('Add Profile', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
