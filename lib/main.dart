import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad2/cubit/main_cubit.dart';
import 'package:zad2/studaent_item.dart';
import 'package:zad2/repostiroy/student_repository.dart';
import 'package:zad2/models/student.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyAppBuffet(),
    ),
  );
}

class MyAppBuffet extends StatelessWidget {
  const MyAppBuffet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(
        StudentRepository(),
      )..getStudent(),
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController nameController;
  late TextEditingController groupController;
  late TextEditingController courseController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Студенты'),
      ),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if (state is MainInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MainStudentsFetched) {
            return Column(
              children: state.students
                  .map(
                    (e) => StudentItem(
                      student: e,
                      delete: context.read<MainCubit>().deleteStudent,
                      update: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            nameController =
                                TextEditingController(text: e.name);
                            groupController =
                                TextEditingController(text: e.group);
                            courseController =
                                TextEditingController(text: e.course);
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                    ),
                                  ),
                                  TextField(
                                    controller: groupController,
                                    decoration: InputDecoration(
                                      hintText: 'Group',
                                    ),
                                  ),
                                  TextField(
                                    controller: courseController,
                                    decoration: InputDecoration(
                                      hintText: 'Course',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                MaterialButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    context.read<MainCubit>().updateStudent(
                                          Student(
                                            id: e.id,
                                            course:
                                                courseController.text.trim(),
                                            group: groupController.text.trim(),
                                            name: nameController.text.trim(),
                                          ),
                                        );
                                    Navigator.pop(context);
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  )
                  .toList(),
            );
          }
          return Center(
            child: Text(
              (state as MainFailure).message,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              nameController = TextEditingController();
              groupController = TextEditingController();
              courseController = TextEditingController();
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                    TextField(
                      controller: groupController,
                      decoration: InputDecoration(
                        hintText: 'Group',
                      ),
                    ),
                    TextField(
                      controller: courseController,
                      decoration: InputDecoration(
                        hintText: 'Course',
                      ),
                    ),
                  ],
                ),
                actions: [
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      context.read<MainCubit>().addStudent(
                            Student(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              course: courseController.text.trim(),
                              group: groupController.text.trim(),
                              name: nameController.text.trim(),
                            ),
                          );
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
