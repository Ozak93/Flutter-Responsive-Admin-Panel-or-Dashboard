import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageProvider extends ChangeNotifier {
  final storageRef = FirebaseStorage.instance.ref();

  List<String> imgs = [];

  StorageProvider() {
    getImages();
  }
  getImages() async {
    log("called get images");
    try {
      var res = await storageRef.child("pics/cats/").listAll();

      await parseLinks(res);

      log("res is ${res.items.length} and imgs is ${imgs.length}");
      notifyListeners();
    } catch (e) {
      log("error listing storage ${e.toString()}");
      return Future(() => null);
    }
  }

  parseLinks(ListResult x) async {
    for (int i = 0; i < x.items.length; i++) {
      imgs.add(await x.items[i].getDownloadURL());
    }

    notifyListeners();
    return true;
  }
}
