import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/model/user_model.dart' as user_data;
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  get _mAuth => firebaseAuth;

  get _user => _mAuth.currentUser;

  User? get currentUser => FirebaseAuth.instance.currentUser;
  String get currentUserId => currentUser!.uid;

//  String get currentUserId => currentUser == null ? 'sS5NJUusvmOKlJt731JgKnBPxPk1' : currentUser!.uid;

  get currentUid {
    if (_user != null) {
      return _user.name;
    } else {
      return '';
    }
  }

  WriteBatch get batch => firestore.batch();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  get mAuth => firebaseAuth;

  CollectionReference<user_data.UserModel> get usersRef =>
      firestore.collection('users').withConverter<user_data.UserModel>(
          fromFirestore: (snapshot, _) =>
              user_data.UserModel.fromMap(snapshot.data()!),
          toFirestore: (user, _) => user.toMap());
}
