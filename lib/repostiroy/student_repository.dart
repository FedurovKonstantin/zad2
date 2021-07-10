import 'dart:io';
import 'package:zad2/models/student.dart';

import 'package:path_provider/path_provider.dart';

class StudentRepository {
  Future<void> updateStudent(Student student) async {
    final file = await _localFile;
    final lines = await file.readAsLines();
    await file.writeAsString(
      lines.map((e) {
        if (e.split(' ')[0] == student.id) {
          return '${student.id} ${student.name} ${student.course} ${student.group}';
        }
        return e;
      }).join('\n'),
    );
  }

  Future<void> deleteStudent(String id) async {
    final file = await _localFile;
    final lines = await file.readAsLines();
    file.writeAsString(
      lines.where((element) => element.split(' ')[0] != id).join('\n'),
    );
  }

  Future<List<Student>> getStudents() async {
    final file = await _localFile;
    await file.writeAsString('', mode: FileMode.append);
    final lines = await file.readAsLines();
    return lines.map((e) {
      final id = e.split(' ')[0];
      final name = e.split(' ')[1];
      final course = e.split(' ')[2];
      final group = e.split(' ')[3];
      return Student(
        id: id,
        course: course,
        group: group,
        name: name,
      );
    }).toList();
  }

  Future<void> addStudent(Student student) async {
    final file = await _localFile;
    await file.writeAsString(
      '${student.id} ${student.name} ${student.course} ${student.group} \n',
      mode: FileMode.append,
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/students.txt');
  }
}
