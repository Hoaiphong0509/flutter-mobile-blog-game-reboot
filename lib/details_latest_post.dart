import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class LatestPostDetails extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>>? snapshot;

  const LatestPostDetails(this.snapshot, {Key? key}) : super(key: key);

  @override
  _LatestPostDetailsState createState() => _LatestPostDetailsState();
}

class _LatestPostDetailsState extends State<LatestPostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nội dung"),
        backgroundColor: const Color(0xFF222240),
      ),
      backgroundColor: const Color(0xFF222240),
      body: ListView(
        children: <Widget>[
          //First container
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                "${widget.snapshot!.data()?['image']}",
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //End Frist container
          const SizedBox(
            height: 6.0,
          ),
          Container(
            color: const Color(0xFF272B4A),
            margin: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        child: Text(
                          "${widget.snapshot!.data()!["title"][0]}",
                          style: const TextStyle(fontSize: 21.0),
                        ),
                        backgroundColor: const Color(0xFF222240),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Text(
                          "${widget.snapshot!.data()!["title"]}",
                          style: const TextStyle(
                              fontSize: 19.0, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${widget.snapshot!.data()!["content"]}",
                  style: const TextStyle(fontSize: 15.0, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
