import 'package:flutter/material.dart';
import 'package:zad2/models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  final Function(String) delete;
  final Function update;

  const StudentItem({
    Key? key,
    required this.student,
    required this.delete,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Имя ${student.name}'),
              SizedBox(
                height: 5,
              ),
              Text('Курс ${student.course}'),
              SizedBox(
                height: 5,
              ),
              Text(
                'Группа ${student.group}',
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () => update(),
            icon: Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          IconButton(
            onPressed: () => delete(student.id),
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
