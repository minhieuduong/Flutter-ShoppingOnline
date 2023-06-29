import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_3/Constants/constants.dart';
import 'package:flutter_application_3/Models/product_model/product_model.dart';
import 'package:flutter_application_3/Models/user_model/user_model.dart';
import '../Models/category_model/category_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //Phân loại
  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryView(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("product")
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  //phổ biến
  Future<List<ProductModel>> getPopular() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("product").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  //Mới nhất
  Future<List<ProductModel>> getNewest() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("product").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  // Future<List<UserModel>> getUser() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore.collection("users").get();

  //     List<UserModel> categoriesList =
  //         querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();

  //     return categoriesList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }
  // Future<UserModel> getUserInformation() async {
  //   DocumentSnapshot<Map<String, dynamic>> querySnapshot =
  //       await _firebaseFirestore
  //           .collection("users")
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .get();

  //   return UserModel.fromJson(querySnapshot.data()!);
  // }
  // Future<bool> uploadOrderedProductFirebase() async {
  //   try {
  //     _firebaseFirestore.collection("usersOders").doc();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
