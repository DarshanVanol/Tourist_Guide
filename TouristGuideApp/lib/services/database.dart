import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  final CollectionReference placeCollection =
      Firestore.instance.collection('places');

  DatabaseService({this.uid});

  Future updateUserData(String place, String name) async {
    return await placeCollection.document(uid).updateData({
      'id': FieldValue.arrayUnion([place]),
      'name': FieldValue.arrayUnion([name])
    });
  }

  Future newUserData(String place, String name) async {
    print("id is");
    print(uid);
    return await placeCollection.document(uid).setData({
      'id': FieldValue.arrayUnion([place]),
      'name': FieldValue.arrayUnion([name])
    });
  }

  Future deleteUserData(String place, String name) async {
    return await placeCollection.document(uid).updateData({
      'id': FieldValue.arrayRemove([place]),
      'name': FieldValue.arrayRemove([name])
    });
  }

  Stream<QuerySnapshot> get places {
    return placeCollection.snapshots();
  }
}
