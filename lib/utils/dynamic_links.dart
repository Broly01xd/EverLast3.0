import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

class DynamicLinkProvider {
  Future<String> createLink(String getCurrentDocumentId,
      {bool isShortLink = true}) async {
    final instanceLink = FirebaseDynamicLinks.instance;

    final String _testString =
        'To test: long press link and then copy and click from a non-browser '
        "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
        'is properly setup. Look at firebase_dynamic_links/README.md for more '
        'details.';

    final String DynamicLink = 'https://everlast.page.link';
    final String Link = 'https://everlast.page.link/MEGs';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://everlast.page.link',
      longDynamicLink: Uri.parse(
        'https://everlast.page.link?efr=0&ibi=com.example.everlast&apn=com.example.everlast&imv=0&amv=0&link=https%3A%2F%2Fexample%2F$getCurrentDocumentId&ofl=https://ofl-example.com',
      ),
      link: Uri.parse('$DynamicLink/$getCurrentDocumentId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.everlast',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.everlast',
        minimumVersion: '0',
      ),
    );

    if (isShortLink) {
      final ShortDynamicLink shortLink =
          await instanceLink.buildShortLink(parameters);
      return shortLink.shortUrl.toString();
    } else {
      return (await instanceLink.buildLink(parameters)).toString();
    }
  }

  Future<String?> getCurrentDocumentId(
      String collectionPath, String documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(documentId)
          .get();
      return documentSnapshot.id;
    } catch (e) {
      print('Error getting document ID: $e');
      return null;
    }
  }

  void initDynamicLink(BuildContext context) async {
    final instanceLink = await FirebaseDynamicLinks.instance;

    instanceLink.onLink.listen((dynamicLinkData) {
      debugPrint('printin heresfdffd');
    }).onError((error) {
      print(error.message);
    });
  }
}
