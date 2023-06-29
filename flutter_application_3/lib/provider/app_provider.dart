import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_3/Constants/constants.dart';
import 'package:flutter_application_3/Firebase/firebase_firestore.dart';
import 'package:flutter_application_3/Models/product_model/product_model.dart';
import 'package:flutter_application_3/Models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  final List<ProductModel> cartProductList = [];
  final List<ProductModel> favouriteProductList = [];
  final List<ProductModel> buyProductList = [];

  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;
  //cart
  void addCartProduct(ProductModel productModel) {
    cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => cartProductList;
  void updateQty(ProductModel productModel, int qty) {
    int index = cartProductList.indexOf(productModel);
    cartProductList[index].qty = qty;
    notifyListeners();
  }

  //favourite
  List<ProductModel> favouriteList = [];
  void addFavouriteProduct(ProductModel productModel) {
    favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getfavouriteProductList => favouriteProductList;

  //order
  void addBuyProduct(ProductModel productModel) {
    buyProductList.add(productModel);
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => buyProductList;
  ////// USer Information
  // void getUserInfoFirebase() async {
  //   _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
  //   notifyListeners();
  // }

  // void updateUserInfoFirebase(
  //     BuildContext context, UserModel userModel, File? file) async {
  //   if (file == null) {
  //     showLoaderDialog(context);

  //     _userModel = userModel;
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(_userModel!.id)
  //         .set(_userModel!.toJson());
  //     Navigator.of(context, rootNavigator: true).pop();
  //     Navigator.of(context).pop();
  //   } else {
  //     showLoaderDialog(context);

  //     String imageUrl =
  //         await FirebaseStorageHelper.instance.uploadUserImage(file);
  //     _userModel = userModel.copyWith(image: imageUrl);
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(_userModel!.id)
  //         .set(_userModel!.toJson());
  //     Navigator.of(context, rootNavigator: true).pop();
  //     Navigator.of(context).pop();
  //   }
  //   showMessage("Successfully updated profile");

  //   notifyListeners();
  // }
}
