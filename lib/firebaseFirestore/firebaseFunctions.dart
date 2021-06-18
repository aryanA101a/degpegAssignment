import 'package:cloud_firestore/cloud_firestore.dart';

final fireInstance = FirebaseFirestore.instance;

class FirebaseFunctions {
  Future<void> increaseViewCount(String videoId) async {
    await fireInstance.runTransaction((transaction) async {
      DocumentReference postRef =
          fireInstance.collection('assignment').doc(videoId);
      DocumentSnapshot? snapshot = await transaction.get(postRef);
      int viewCount = snapshot.get('views') + 1;
      transaction.update(postRef, {'views': viewCount});
    });
  }

  static getSnapshot() async {
    return await fireInstance
        .collection("assignment")
        .snapshots();
  }
}
