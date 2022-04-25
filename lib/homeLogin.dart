import 'package:flutter/material.dart';
import 'package:modul1_old/main.dart';

class HomeLogin extends StatefulWidget {
  final String? name, nim;

  const HomeLogin({Key? key, required this.name, required this.nim})
      : super(key: key);

  @override
  State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("home login"),
      ),*/
      body: Container(
        // width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("nama : ${widget.name}"),
              Text("NIM : ${widget.nim}"),
              TextButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp() ));
                  },
                  icon: Icon(Icons.home),
                  label: Text("Back TO Home")),
            ],
          ),
        ),
      ),
    );
  }
}
