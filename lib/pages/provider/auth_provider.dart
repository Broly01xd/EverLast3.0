import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/model/event_model.dart';
import 'package:everlast/model/user_model.dart';
import 'package:everlast/pages/otp_page.dart';
import 'package:everlast/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  EventModel? _eventModel;
  EventModel get eventModel => _eventModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  AuthProvider() {
    checkSignIn();
    // getDataFromFirestore();
  }

  // get DateTime => null;

  // Get the UID of the current user
  String? getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSigIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

//sign in
  Future<void> signInwithPhone(
    BuildContext context,
    String phoneNumber,
    Function() onCompleted,
  ) async {
    _isLoading =
        true; // Set isLoading to true before starting the verification process
    notifyListeners(); // Notify listeners to update the UI

    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          _isLoading =
              false; // Set isLoading to false after successful verification
          notifyListeners(); // Notify listeners to update the UI
        },
        verificationFailed: (error) {
          _isLoading =
              false; // Set isLoading to false in case of verification failure
          notifyListeners(); // Notify listeners to update the UI
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          _isLoading =
              false; // Set isLoading to false when code is sent (UI transition)
          notifyListeners(); // Notify listeners to update the UI

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPage(
                verificationId: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      _isLoading =
          false; // Set isLoading to false in case of authentication exception
      notifyListeners(); // Notify listeners to update the UI
      showSnackBar(context, e.message.toString());
      onCompleted();
    }
  }

  //verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // database ops
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("user exists");
      return true;
    } else {
      print("not exists");
      return false;
    }
  }

  Future<String?> getEventPicURL(String eventId) async {
    try {
      await Firebase
          .initializeApp(); // Initialize Firebase if you haven't already

      final CollectionReference eventsCollection =
          FirebaseFirestore.instance.collection('events');
      final DocumentSnapshot eventDocument =
          await eventsCollection.doc(eventId).get();

      if (eventDocument.exists) {
        final Map<String, dynamic>? data =
            eventDocument.data() as Map<String, dynamic>?;
        if (data != null) {
          final String? eventPicURL = data['EventPic'] as String?;
          print(eventPicURL);
          return eventPicURL;
        } else {
          return null; // Handle the case where data is null or not a Map
        }
      } else {
        return null; // Event document doesn't exist
      }
    } catch (e) {
      print("Error fetching eventpic URL: $e");
      return null; // An error occurred
    }
  }

  Future<void> saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File? profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (profilePic != null) {
        userModel.profileImage =
            await storeFileToStorage("profilePic/$_uid", profilePic);
      }
      userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      userModel.phone = _firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid = _firebaseAuth.currentUser!.uid;
      _userModel = userModel;

      //uploading to database1
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage
        .ref()
        .child('$ref-${DateTime.now().millisecondsSinceEpoch}')
        .putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFromFirestore() async {
    if (_firebaseAuth.currentUser == null) {
      debugPrint('User does not exits');
      return;
    }
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        _userModel = UserModel(
          name: snapshot['name'],
          email: snapshot['email'],
          profileImage: snapshot['profileImage'],
          createdAt: snapshot['createdAt'],
          phone: snapshot['phone'],
          uid: snapshot['uid'],
        );
        _uid = userModel.uid;
      }
    });
  }

  //storing data locally
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future saveEventDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("event_model", jsonEncode(eventModel.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

  //event
  void saveEventDataToFirebase({
    String? documentId,
    required BuildContext context,
    required EventModel eventModel,
    required File eventPic,
    required Function(String?) onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (!context.mounted) {
        return;
      }

      final id = documentId ?? _firebaseFirestore.collection("events").doc().id;

      await storeFileToStorage("eventPic/$_uid", eventPic).then((value) {
        eventModel.id = _uid;
        eventModel.eventPic = value;
        eventModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        // eventModel.phone = _firebaseAuth.currentUser!.phoneNumber!;
        // userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _eventModel = eventModel;

      //uploading to database
      await _firebaseFirestore
          .collection("events")
          .doc(id) // leave doc path to blank to auto  generate the document id
          .set(eventModel.toMap())
          .then((value) {
        onSuccess(id);
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
}
