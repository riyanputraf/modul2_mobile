import 'package:flutter/material.dart';
import 'package:modul1_old/dummy_data.dart';
import 'package:modul1_old/homeLogin.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userName = new TextEditingController();
  final _password = new TextEditingController();
  bool checkLogin = false;

  /*saveData() async {
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString('userName', _userName.text.toString());
    localStorage.setString('password', _password.text.toString());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeLogin(
                  name: "halo",
                  nim: "test",
                )));
    for (var data in DummyData.data) {
      if (_userName == data['username']) {
        print("berhasil");
        await localStorage.setString('nim', data['Nim']);
        String? name = localStorage.getString('userName');
        String? nim = localStorage.getString('nim');
        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeLogin(name: "halo", nim: "test",)));
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _userName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  prefixIcon: Icon(
                    Icons.people,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.purpleAccent,
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  final localStorage = await SharedPreferences.getInstance();
                  for (var data in DummyData.data) {
                    print("test");
                    if (_userName.text == data['username']) {
                      print("berhasil");
                      await localStorage.setString('nim', data['Nim']);
                      await localStorage.setString(
                          'userName', _userName.text.toString());
                      await localStorage.setString('nameUser', data['nama']);
                      await localStorage.setBool('checkLogin', false);
                      String? nim = localStorage.getString('nim');
                      String? name = localStorage.getString('userName');
                      String? nameUser = localStorage.getString('nameUser');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeLogin(
                                    name: nameUser,
                                    nim: nim,
                                  )));
                      break;
                    } else if (15 == data['id']) {
                      print("failed");
                      loginFailed(context);
                      break;
                    }
                  }
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginFailed(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Login Gagal",
      desc: "Username atau Password Salah",
      buttons: [
        DialogButton(
          child: Text(
            "Kembali",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        )
      ],
    ).show();
  }
}
