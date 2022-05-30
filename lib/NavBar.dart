import 'package:flutter/material.dart';
import 'package:modul1_old/homeLogin.dart';
import 'package:modul1_old/login.dart';
import 'package:modul1_old/main.dart';
import 'package:modul1_old/shared/listitem.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';



class NavBar extends StatefulWidget {

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late final ListItem listItem;
  String? finalName = "User";
  String? finalNim = "Your NIM";

  getData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('nameUser');
    var nim = sharedPreferences.getString('nim');
    setState(() {
      if(name != null && nim != null){
        finalName = name;
        finalNim = nim;
      }else{
        finalName = "Username Aplication";
        finalNim = "User NIM Aplication";
      }

    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('${finalName}'),
              accountEmail: Text('${finalNim}'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://w7.pngwing.com/pngs/527/663/png-transparent-logo-person-user-person-icon-rectangle-photography-computer-wallpaper.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,

                ),

              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                  'https://img.freepik.com/free-photo/stack-books-black-background_23-2147846050.jpg?size=626&ext=jpg'
                ),
                fit: BoxFit.cover,
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Login"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Favourite"),
            onTap: (){
              favourite();
              print('press');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: (){
              print('press');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("Read List"),
            onTap: (){
              print('press');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              // logOut(context);
              SharedPreferences loginData = await SharedPreferences.getInstance();
              loginData.remove('checkLogin');
              loginData.remove('nim');
              loginData.remove('userName');
              loginData.remove('nameUser');

              setState(() {
                finalName = "Username Aplication";
                finalNim = "User NIM Aplication";

              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
// Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Login()));
              print('press');

            },
          ),
        ],
      ),
    );
  }

  void logOut(BuildContext context)  {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Anda LogOut",
      desc: "Username atau Password Salah",
      buttons: [
        DialogButton(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () async {
            // Navigator.of(context, rootNavigator: true).pop(),
            final result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => Login()));

            if(result == null || result != null){
              setState(() {
                Navigator.of(context, rootNavigator: true).pop();
              });
            }else{
              Navigator.of(context, rootNavigator: true).pop();
            }

          }

        )
      ],
    ).show();
  }

  void favourite() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    bool check = (loginData.getBool('checkLogin') ?? true);

    if(check == false){
      Alert(
        context: context,
        type: AlertType.success,
        title: "Berhasil terbuka",
        desc: "Fitur terbatas bagi user login",
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
    }else{
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Silahkan Login dulu",
        desc: "Fitur terbatas bagi user login",
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
}
