import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul1_old/auth.dart';
import 'package:modul1_old/auth2.dart';
import 'package:modul1_old/dummy_data.dart';
import 'package:modul1_old/hasil.dart';
import 'package:modul1_old/homeLogin.dart';
import 'package:modul1_old/main.dart';
import 'package:provider/provider.dart';
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Belum Punya Akun ? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Register',
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
              SizedBox(
                height: 5,
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
                    if (_userName.text == data['username'] &&
                        _password.text == data['password']) {
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
              SizedBox(
                height: 5,
              ),
              Text(
                'Atau',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Hasil() ));
                  },
                  child: Text(
                    'Login Google',
                    style: TextStyle(fontSize: 20),
                  )),
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
