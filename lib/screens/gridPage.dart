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
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.amber,
        title: Text(
          'Popular',
          style: TextStyle(color: Colors.black),
        ),
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
                                  childAspectRatio: 3 / 2.5,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3),
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
                                      builder: (context) => VideoPlayerPage(
                                        title: snapshot.data!.docs[index]
                                            .get('title'),
                                        description: snapshot.data!.docs[index]
                                            .get('description'),
                                        videoUrl: snapshot.data!.docs[index]
                                            .get('videoUrl'),
                                        videoId: snapshot.data!.docs[index]
                                            .get('videoId'),
                                        views: snapshot.data!.docs[index]
                                            .get('views'),
                                        watchtime: snapshot.data!.docs[index]
                                            .get('watchtime'),
                                      ),
                                    ));
                              },
                              child: SizedBox(
                                // height: 80,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(12)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: double.infinity,
                                              child: Card(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(12)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    snapshot.data!.docs[index]
                                                        .get('thumbnail'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${snapshot.data!.docs[index].get('views')} views',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  .get('title'),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
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
