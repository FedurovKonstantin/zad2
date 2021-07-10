part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainFailure extends MainState {
  String message;

  MainFailure(this.message);
}

class MainInProgress extends MainState {}

class MainStudentsFetched extends MainState {
  List<Student> students;

  MainStudentsFetched(this.students);
}
