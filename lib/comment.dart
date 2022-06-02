import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool loadingStatus = true;
  List<dynamic> response = [];

  Future<void> getApi() async {
    loadingStatus = true;
    try {
      var res = await http.get(Uri.parse(widget.url));
      if (res.statusCode == 200) {
        print('comment ok');
      } else {
        print('comment deo on roi');
        print(res.body.toString());
      }
      response = convert.jsonDecode(res.body) as List<dynamic>;
      setState(() {
        loadingStatus = false;
      });
    } catch (e) {
      print(e);
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
      appBar: AppBar(
        title: const Text("dio demo"),
      ),
      body: loadingStatus == true
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${response[index]["name"].toString()}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text("Email: ${response[index]["email"].toString()}"),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Body: ${response[index]["body"].toString()}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
              itemCount: resLength,
            ),
    );
  }
}
