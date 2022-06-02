import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:list_api/comment.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool loadingStatus = true;
  var commentResponse;

  Future<void> getApi() async {
    loadingStatus = true;
    try {
      var res = await http.get(Uri.parse(widget.url));
      if (res.statusCode == 200) {
        print('ok');
      } else {
        print('not ok');
      }
      commentResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      setState(() {
        loadingStatus = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: loadingStatus == true
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title: ${commentResponse["title"].toString()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Body: ${commentResponse["body"].toString()}"),
                  const Divider(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('COMMENT'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(url: ("${widget.url}/comments")) ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
