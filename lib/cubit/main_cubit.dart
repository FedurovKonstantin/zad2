import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zad2/repostiroy/student_repository.dart';

import '../models/student.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  StudentRepository studentRepository;

  MainCubit(
    this.studentRepository,
  ) : super(MainInProgress());

  void addStudent(Student student) async {
    try {
      await studentRepository.addStudent(student);
      final students = await studentRepository.getStudents();
      emit(MainStudentsFetched(students));
    } on Exception catch (e) {
      emit(MainFailure(e.toString()));
    }
  }

  void deleteStudent(String id) async {
    try {
      await studentRepository.deleteStudent(id);
      final students = await studentRepository.getStudents();
      emit(MainStudentsFetched(students));
    } on Exception catch (e) {
      emit(MainFailure(e.toString()));
    }
  }

  void updateStudent(Student student) async {
    try {
      await studentRepository.updateStudent(student);
      final students = await studentRepository.getStudents();
      emit(MainStudentsFetched(students));
    } on Exception catch (e) {
      emit(MainFailure(e.toString()));
    }
  }

  void getStudent() async {
    try {
      final students = await studentRepository.getStudents();
      emit(MainStudentsFetched(students));
    } on Exception catch (e) {
      emit(MainFailure(e.toString()));
    }
  }
}
