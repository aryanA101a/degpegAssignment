// import 'package:assignment/constants.dart';
import 'package:assignment/firebaseFirestore/firebaseFunctions.dart';
import 'package:assignment/screens/videoPlayer/videoPlayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GridPage extends StatefulWidget {
  const GridPage({Key? key}) : super(key: key);

  @override
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();
  late Stream<QuerySnapshot> dataStream;
  Future initData() async {
    await FirebaseFunctions.getSnapshot().then((val) {
      dataStream = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DegPeg'),
      ),
      body: Container(
          child: FutureBuilder(
        future: initData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: StreamBuilder<QuerySnapshot>(
                stream: dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Container(child: CircularProgressIndicator()));
                  }
                  return snapshot.data == null
                      ? Center(
                          child: Container(
                            child: Text("Empty"),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext ctx, index) {
                            print(
                              snapshot.data!.docs[index].get('views'),
                            );
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HlsAudioPage(
                                        snapshot.data!.docs[index]
                                            .get('videoUrl'),
                                        snapshot.data!.docs[index]
                                            .get('videoId'),
                                        snapshot.data!.docs[index].get('views'),
                                        snapshot.data!.docs[index]
                                            .get('watchtime'),
                                      ),
                                    ));
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(12)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      snapshot.data!.docs[index]
                                          .get('thumbnail'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            );
                          });
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          return Text('qpppppp');
        },
      )),
    );
  }
}
