import 'dart:io';

class TodoModel {
  final String id;
  final String todo;
  final String pengarang;
  final File image;

  TodoModel({
    required this.id,
    required this.todo,
    required this.pengarang,
    required this.image,
  });
}
