import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:list_api/post_page.dart';



class ListPostPage extends StatefulWidget {
  const ListPostPage({Key? key}) : super(key: key);

  @override
  State<ListPostPage> createState() => _ListPostPageState();
}

class _ListPostPageState extends State<ListPostPage> {
  bool loadingStatus = true;
  List<dynamic> response = [];

  Future<void> getApi() async {
    loadingStatus = true;
    try {
      var res = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (res.statusCode == 200) {

      } else {

      }
      response = convert.jsonDecode(res.body) as List<dynamic>;
      setState(() {
        loadingStatus = false;
      });
    }
    catch (e) {

    }
  }
  @override
  void initState() {
    print("init");
    super.initState();
    getApi();
  }

  @override
  Widget build(BuildContext context) {
    int resLength = response.length;
    return Scaffold(
      appBar: AppBar(title:const Text("dio demo"),),
      body: loadingStatus == true ? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  String url = ("https://jsonplaceholder.typicode.com/posts/${response[index]["id"]}");
                  print(url);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostPage(url: url)));
                                  },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title: ${response[index]["title"].toString()}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Body: ${response[index]["body"].toString()}"),
                    const Divider(),
                  ],
                ),
              ),
            );
          },
          itemCount: resLength,
      ),
    );
  }
}
