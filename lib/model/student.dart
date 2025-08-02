class Student {
  final int? id;
  final String name;
  final int age;
  final String department;

  Student({this.id, required this.name, required this.age, required this.department});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'department': department,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      department: map['department'],
    );
  }
}