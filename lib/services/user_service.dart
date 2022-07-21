import 'dart:io';
import 'package:path/path.dart';
import 'package:airplane/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Set ke database firestore
class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'hobby': user.hobby,
        'balance': user.balance,
        'imagePath': user.imagePath
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getUserbyId(String id) async {
    try {
      DocumentSnapshot docUser = await _userReference.doc(id).get();

      return UserModel(
        id: id,
        email: docUser['email'],
        name: docUser['name'],
        hobby: docUser['hobby'],
        balance: docUser['balance'],
        imagePath: docUser['imagePath'],
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateBalance(int newBalance) async {
    try {
      DocumentReference docUser =
          _userReference.doc(FirebaseAuth.instance.currentUser!.uid);
      await docUser.update({'balance': newBalance});
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(
      String newName, String newHobby, String newImagePath) async {
    try {
      DocumentReference docUser =
          _userReference.doc(FirebaseAuth.instance.currentUser!.uid);
      await docUser.update(
          {'name': newName, 'hobby': newHobby, 'imagePath': newImagePath});
    } catch (e) {
      throw e;
    }
  }

  Future<String> uploadImage(File imageFile) async {
    String fileName = basename(imageFile.path);

    Reference storageReference =
        FirebaseStorage.instance.ref('users').child(fileName);

    await storageReference.putFile(imageFile);

    String url = await storageReference.getDownloadURL();

    return url;
  }
}
