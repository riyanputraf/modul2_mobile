import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modul1_old/dio_client.dart';

import 'buku_test.dart';
import 'post.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  var requesting = false;
  late DioClient dioClient;
  late Future<Post> post;
  late Future<Buku> buku;
  late Future<List<Buku>> posts;

  late Response response;
  Dio dio = Dio();

  bool error = false; //for error status
  bool loading = false; //for data featching status
  String errmsg = ""; //to assing any error message from API/runtime
  var apidata; //for decoded JSON data

  getData() async {
    setState(() {
      loading = true;  //make loading true to show progressindicator
    });

    String url = "http://10.0.2.2/api/buku";
    //don't use "http://localhost/" use local IP or actual live URL

    Response response = await dio.get(url);
    apidata = response.data; //get JSON decoded data from response

    print(apidata); //printing the JSON recieved

    if(response.statusCode == 200){
      //fetch successful
      debugPrint(response.toString());
      if(apidata["error"]){ //Check if there is error given on JSON
        error = true;
        errmsg  = apidata["msg"]; //error message from JSON
      }
    }else{
      error = true;
      errmsg = "Error while fetching data.";
    }

    loading = false;
    setState(() {}); //refresh UI
  }

  @override
  void initState() {
    // TODO: implement initState
  getData();
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (requesting)
          FutureBuilder<Buku>(
              future: buku,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text('Title -> ${snapshot.data!.judul}'),
                        Text('Body -> ${snapshot.data!.genre}'),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }
              ),
       /* FutureBuilder<List<Buku>>(
              future: posts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text('Title -> ${snapshot.data![0].judul}'),
                        Text('Body -> ${snapshot.data![0].genre}'),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }
              ),*/

        Center(
          child: Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: ()  {
                    buku =  dioClient.fetchPost(3);

                    setState(() {
                      requesting = true;
                    });
                  },
                  child: const Text("Get post")),
              ElevatedButton(
                  onPressed: ()  {
                    posts =  dioClient.fetchPosts();

                    setState(() {
                      requesting = true;
                    });
                  },
                  child: const Text("Get All post")),
              ElevatedButton(
                  onPressed: () {
                    buku = dioClient.createPost('Sang Kora', 2, 'Adventure');
                    setState(() {
                      requesting = true;
                    });
                  },
                  child: const Text("Create Post")),
              ElevatedButton(
                  onPressed: () {
                    buku = dioClient.updatePost(
                        3, 'Kora', 1, 'Adventure');
                    setState(() {

                      requesting = true;
                    });
                  },
                  child: const Text("Update")),
              ElevatedButton(
                  onPressed: () {
                    dioClient.deletePost(5);
                    setState(() {
                      buku =  dioClient.fetchPost(10);
                      requesting = true;
                    });
                  },
                  child: const Text("Delete"))
            ],
          ),
        )
      ],
    ));
  }
}
