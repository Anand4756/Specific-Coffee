import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/models/coffee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeeapp/models/user.dart';

import '../models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffee');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Coffee> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Coffee(
          name: doc['name'] ?? '',
          strength: doc['strength'] ?? 0,
          sugars: doc['sugars'] ?? '0');
    }).toList();
  }

  Profiledata _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Profiledata(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strength']);
  }

  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots().map(_brewListFromSnapshot);
  }

  // Stream<QuerySnapshot> get coffee {
  //   return coffeeCollection.snapshots();
  // }
  Stream<Profiledata> get userData {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
