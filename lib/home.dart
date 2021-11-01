import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:async";
import "package:gameblog/details_latest_post.dart";
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget {
  const Home({Key? key, }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot>? subscription;

  late List<DocumentSnapshot<Map<String, dynamic>>> snapshot;
  // late List<DocumentSnapshot> snapshot;
  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection('LatestPost');

  // CollectionReference collectionReference =
  //     FirebaseFirestore.instance.collection('LatestPost');

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnap) {
      setState(() {
        snapshot = datasnap.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game News"),
        backgroundColor: const Color(0xFF222240),
      ),
      //Drawer start
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF272B4A),
          child: ListView(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text("Game News"),
                accountEmail: null,
                decoration: BoxDecoration(color: Color(0xFF222240)),
              ),
              ListTile(
                title: const Text(
                  "News",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(
                  Icons.pages,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              ListTile(
                title: const Text(
                  "Esport",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(
                  Icons.games,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              ListTile(
                title: const Text(
                  "Review",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(
                  Icons.reviews,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              ListTile(
                title: const Text(
                  "Blog",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(
                  Icons.analytics,
                  color: Colors.white,
                  size: 20.0,
                ),
              )
            ],
          ),
        ),
      ),
      //Drawer end
      backgroundColor: const Color(0xFF222240),
      body: ListView(
        children: <Widget>[
          //First container start
          Container(
            height: 190.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Mới nhất",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 130,
                  margin: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        width: 300.0,
                        color: const Color(0xFF272B4A),
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  "${snapshot[index].data()?['image']}",
                                  fit: BoxFit.cover,
                                  height: 130,
                                ),
                              )

                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LatestPostDetails(snapshot[index])));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${snapshot[index].data()?['title']}",
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "${snapshot[index].data()?['content']}",
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: const <Widget>[
                                          Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.deepOrange,
                                          ),
                                          SizedBox(width: 5.0,),
                                          Text(
                                            "Xem",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          //First container end
          const SizedBox(height: 7.0,),
          //Second Carousel Container start
          Container(
            margin: const EdgeInsets.all(8.0),
            height: 200.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: const Duration(milliseconds: 600),
                dotSize: 6.0,
                dotIncreasedColor: const Color(0xFFFF335C),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                borderRadius: true,
                images: [
                  NetworkImage('https://st.quantrimang.com/photos/image/2019/06/11/lol-la-gi-2.jpg'),
                  NetworkImage('https://genk.mediacdn.vn/139269124445442048/2021/4/16/league-of-legends-1-16185440791431765832411.jpg'),
                ],
              ),
            ),
          )
          //Second Carousel Container end
        ],
      ),
    );
  }
}
