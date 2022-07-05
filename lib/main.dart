import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modul1_old/NavBar.dart';
import 'package:modul1_old/auth.dart';
import 'package:modul1_old/details.dart';
import 'package:modul1_old/homeLogin.dart';
import 'package:modul1_old/listwidget.dart';
import 'package:modul1_old/login.dart';
import 'package:modul1_old/shared/listitem.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:modul1_old/todo_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// @dart=2.9
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => TodoListProvider(),
        )


      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          )
        )
      ),
  )
    );

}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double ratingC = 0;

  List<ListItem> listTiles = [
    ListItem(
        "https://www.tagar.id/Asset/uploads2019/1607941807684-cover-novel-padang-bulan.jpg",
        "Padang Bulan",
        "Andrea Hirata",
        'Rating ',
        2),
    ListItem(
        "https://www.tagar.id/Asset/uploads2019/1607941366232-cover-novel-laskar-pelangi.jpg",
        "Laskar Pelangi",
        "Andrea Hirata",
        "none",
        0),
    ListItem(
        "https://www.tagar.id/Asset/uploads2019/1607941441748-cover-novel-ayah.jpg",
        "Ayah",
        "Andrea Hirata",
        "none",
        0),
    ListItem(
        "https://www.tagar.id/Asset/uploads2019/1607941470186-cover-novel-guru-aini.jpg",
        "Guru Aini",
        "Andrea Hirata",
        "none",
        0),
    ListItem(
        "https://www.tagar.id/Asset/uploads2019/1607941409812-cover-novel-orangorang-biasa.jpg",
        "Orang-Orang Biasa",
        "Andrea Hirata",
        "none",
        0),
    ListItem(
        "https://1.bp.blogspot.com/-EV9GcFn5QIQ/VvEo3rfBskI/AAAAAAAAAA8/ON7NEwyTYOYw1gMqcQl_4A9ysZ7h87uuQ/s1600/20160321_172131.jpg",
        "Edensor",
        "Andrea Hirata",
        "none",
        0),
  ];

  List<ListItem> listTiles2 = [
    ListItem(
        "https://cf.shopee.co.id/file/384ebd3371e4c4c4d08e842054a85e95",
        "Daruma-San",
        "Fida Husna",
        'Rating ',
        2),
    ListItem(
        "https://inc.mizanstore.com/aassets/img/com_cart/produk/fantasteengone-republish.jpg",
        "Gone",
        "Dini Ocktariana",
        "28 Jan 2022",
        0),
    ListItem(
        "https://images.tokopedia.net/img/cache/700/VqbcmM/2020/12/26/b915e990-44e3-424a-a8d0-b6b027a19cd0.jpg",
        "Ghost Dormitory",
        "Sucia Ramadhani",
        "28 Jan 2022",
        0),
    ListItem(
        "https://inc.mizanstore.com/aassets/img/com_cart/produk/fantasteencharlie-can-we-play.jpg",
        "Charlie Can We Play",
        "Francisca Intan",
        "28 Jan 2022",
        0),
    ListItem(
        "https://media.karousell.com/media/photos/products/2021/7/3/fantasteen_house_of_lavender_t_1625270899_cc8372cd.jpg",
        "House Of Lavender",
        "Faishal D.P.",
        "28 Jan 2022",
        0),
    ListItem(
        "https://cf.shopee.co.id/file/3719e3e610022cd79b95028776275487",
        "Lucid Dream",
        "Ziggy",
        "28 Jan 2022",
        0),
  ];

  List<Tab> _tablist = [
    Tab(
      child: Text(
        "Top",
        style: TextStyle(
          fontSize: 21.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        "Horror",
        style: TextStyle(
          fontSize: 21.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        "Romance",
        style: TextStyle(
          fontSize: 21.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        "Novel",
        style: TextStyle(
          fontSize: 21.0,
        ),
      ),
    ),
  ];

  late TabController _tabcontroller;
  late bool menu;

  void checkLogin() async{
    SharedPreferences loginData = await SharedPreferences.getInstance();
    menu = (loginData.getBool('checkLogin') ?? true);
    var name = loginData.getString('nameUser');
    var nim = loginData.getString('nim');

    print(menu);

    /*if(menu == true){
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Login()));
    }*/
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    _tabcontroller = TabController(vsync: this, length: _tablist.length);
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        toolbarHeight: 110.0,
        /*leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 35.0,
          ),
        ),*/
        backgroundColor: Color(0xFFE040FB),
        centerTitle: true,
        title: Text(
          "ReaBook'S",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            labelColor: Colors.white,
            controller: _tabcontroller,
            tabs: _tablist,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: ListView.builder(
                itemCount: listTiles.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  item: listTiles[index],
                                  tag: listTiles[index]
                                      .ratingValue
                                      .toString())));

                      if (result != null)
                        setState(() {
                          listTiles[index].ratingValue = result;
                        });
                    },
                    child: listWidget(listTiles[index]),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: ListView.builder(
                  itemCount: listTiles2.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    item: listTiles2[index],
                                    tag: listTiles2[index]
                                        .ratingValue
                                        .toString())));

                        if (result != null)
                          setState(() {
                            listTiles2[index].ratingValue = result;
                          });
                      },
                      child: listWidget(listTiles2[index]),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
        ],
      ),
      backgroundColor: Color(0xFF4FC3F7),
    );
  }
}
