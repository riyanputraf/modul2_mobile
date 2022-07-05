import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modul1_old/info_widget.dart';
import 'package:modul1_old/todo_list_provider.dart';
import 'package:modul1_old/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AddEditTodoWidget extends StatefulWidget {
  final String title;
  final TodoModel? todo;

  const AddEditTodoWidget({
    Key? key,
    required this.title,
    this.todo,
  }) : super(key: key);

  @override
  State<AddEditTodoWidget> createState() => _AddEditTodoWidgetState();
}



class _AddEditTodoWidgetState extends State<AddEditTodoWidget> {

  late File _image = File(
      "path/data/user/0/com.example.modul1_old/cache/scaled_image_picker9057902361592213868.jpg");

  late File imagefile;

  Future getImage() async {
    var image = await ImagePicker().pickImage(
      //you can change the source of image by Gallery/Camera
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth:
        800); //i have define the dimension so as to compress the image....while uploading
    //source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
     imagefile = File(image!.path);
    print("Ini image path" + image.path);


  }

  Future<File> _fileFromImageUrl() async {
    final response = await http.get(Uri.parse("https://www.chefbakers.com/userfiles/upload-your-picture6.jpg"));

    final documentDirectory = await getApplicationDocumentsDirectory();

    _image = File(join(documentDirectory.path, 'imagetest.png'));
    imagefile = File(join(documentDirectory.path, 'imagetest.png'));

    _image.writeAsBytesSync(response.bodyBytes);
    imagefile.writeAsBytesSync(response.bodyBytes);

    return _image;
  }

  @override
  void initState() {
    // TODO: implement initState
    _fileFromImageUrl();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _todoController = TextEditingController();
    TextEditingController _pengarang = TextEditingController();

    if (widget.todo != null) {
      _todoController.text = widget.todo!.todo;
      _pengarang.text = widget.todo!.pengarang;
    }
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _todoController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                isDense: true,
                fillColor: Colors.grey.shade100,
                labelText: "Judul Buku",
                hintText: "Masukkan Judul Buku",

              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _pengarang,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                isDense: true,
                fillColor: Colors.grey.shade100,
                labelText: "Pengarang",
                hintText: "Masukkan Pengarang",
              ),
            ),
            Divider(
              color: Colors.white,
              height: 30.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextButton.icon(
                icon: Icon(
                  Icons.file_upload,
                  size: 50.0,
                  color: Colors.black,
                ),
                onPressed: getImage, label: Text("CHOOSE IMAGE", style: TextStyle(color: Colors.black),),

              ),
            ),
            Divider(
              color: Colors.white,
              height: 10.0,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Batal"),
        ),
        TextButton(
          onPressed: () {
            //_fileFromImageUrl();
            setState(() {
              _image = imagefile;
            });
            if (_todoController.text.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return const InfoWidget(
                      title: "Error", content: "Error! Tidak boleh kosong");
                },
              );
            } else {
              if (widget.todo != null) {
                Provider.of<TodoListProvider>(context, listen: false)
                    .updateTodo(TodoModel(
                  id: widget.todo!.id,
                  todo: _todoController.text,
                  pengarang: _pengarang.text,
                  image: _image ,
                ));
              } else {
                const uuid = Uuid();

                Provider.of<TodoListProvider>(context, listen: false).addTodo(
                  TodoModel(
                    id: uuid.v4(),
                    todo: _todoController.text,
                    pengarang: _pengarang.text,
                    image: _image,
                  ),
                );
              }
              Navigator.pop(context);
            }
          },
          child: const Text("Simpan"),
        )
      ],
    );
  }
}
