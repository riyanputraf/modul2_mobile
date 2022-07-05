import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modul1_old/add_edit_todo_widget.dart';
import 'package:modul1_old/todo_list_provider.dart';
import 'package:modul1_old/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  final TodoModel? todo;

  const HomeScreen({Key? key, this.todo}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  late File _image = File("path/data/user/0/com.example.modul1_old/cache/scaled_image_picker9057902361592213868.jpg");
  late File imagefile;

  Future getImage() async {
    var image = await ImagePicker().pickImage(                                //you can change the source of image by Gallery/Camera
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);        //i have define the dimension so as to compress the image....while uploading
    //source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
     imagefile = File(image!.path);
    print("Ini image path" + image.path);

    setState(() {
      _image = imagefile;
    });
  }

  Future<File> _fileFromImageUrl() async {
    final response = await http.get(Uri.parse("https://www.chefbakers.com/userfiles/upload-your-picture6.jpg"));

    final documentDirectory = await getApplicationDocumentsDirectory();

    _image = File(join(documentDirectory.path, 'imagetest.png'));

    _image.writeAsBytesSync(response.bodyBytes);

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


    return Scaffold(
      backgroundColor: const Color(0xFF4FC3F7),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Read List Title"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Consumer<TodoListProvider>(builder: (
          context,
          todoProvider,
          child,

      ) {
        return ListView(
          padding: const EdgeInsets.all(20.0),
          children: todoProvider.todoList.isNotEmpty
          ? todoProvider.todoList.map((todo) {
            return Dismissible(
                key: Key(todo.id),
                background: Container(
                  color: Colors.red.shade300,
                  child: const Center(
                    child: Text(
                      "Yakin Hapus List ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: getImage,
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            child: Image.file(todo.image),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                            child: ListTile(

                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(todo.todo, style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400,
                                  ),),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person, color: Colors.purpleAccent,),
                                      Text(
                                        todo.pengarang,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AddEditTodoWidget(
                                        title: "Edit List",
                                        todo: todo,
                                      );
                                    });

                              },
                            ),

                        ),

                      ],
                    ),
                  ) ,
                ),
            onDismissed: (direction){
                  Provider.of<TodoListProvider>(
                    context,
                    listen: false,
                  ).removeTodo(todo);
            },
            );
          }).toList()
          : [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -100.0,
              child: const Center(
                child: Text(
                  "Read List Masih kosong",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: (){

          showDialog(
              context: context,
              builder: (context) {
                return const AddEditTodoWidget(title : "Tambahkan List");
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }


}
