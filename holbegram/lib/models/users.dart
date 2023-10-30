import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? uid;
  String? email;
  String? username;
  String? bio;
  String? photoUrl;
  List<dynamic>? follwers;
  List<dynamic>? follwing;
  List<dynamic>? posts;
  List<dynamic>? saved;
  String? searchKey;
  Users({
    this.uid,
    this.email,
    this.username,
    this.bio,
    this.photoUrl,
    this.follwers,
    this.follwing,
    this.posts,
    this.saved,
    this.searchKey,
  });
  // static Users fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data();
  //   return Users(
  //     uid: snapshot.data["uid"],
  //     email: snapshot.data['email'],
  //     username: snapshot.data['username'],
  //     bio: snapshot.data['bio'],
  //     photoUrl: snapshot.data['photoUrl'],
  //     follwers: snapshot.data['follwers'],
  //     follwing: snapshot.data['follwing'],
  //     posts: snapshot.data['posts'],
  //     saved: snapshot.data['saved'],
  //     searchKey: snapshot.data['searchKey'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'photoUrl': photoUrl,
      'followers': follwers,
      'following': follwing,
      'posts': posts,
      'saved': saved,
      'searchKey': searchKey,
    };
  }
}
