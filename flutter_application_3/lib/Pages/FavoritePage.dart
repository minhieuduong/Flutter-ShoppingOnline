import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Pages/Product_detail.dart';
import 'package:flutter_application_3/Widgets/DiscountWidget.dart';
import 'package:flutter_application_3/provider/app_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/product_model/product_model.dart';
import 'HomePage.dart';
import 'AccountPage.dart';
import 'CartPage.dart';
import 'OrderPage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // bool _hideNavBar = false;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      // }
    } else if (index == 1) {
      if (ModalRoute.of(context)?.settings.name == '/') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavoritePage(),
          ),
        );
      }
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPage(),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 69,
        title: Text(
          'Danh sách yêu thích',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red, // Đặt màu của mũi tên quay lại
          size: 24,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Icon(
                      CupertinoIcons.cart,
                      color: Colors.red,
                    ),
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: appProvider.getfavouriteProductList.isEmpty
          ? Center(
              child: Text("Danh sách yêu thích trống"),
            )
          : ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.only(bottom: 50),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: appProvider.getfavouriteProductList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1,
                                childAspectRatio: 0.77,
                                crossAxisCount: 2),
                        itemBuilder: (ctx, index) {
                          ProductModel singleProduct =
                              appProvider.getfavouriteProductList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetails(product: singleProduct),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 7),
                                  child: Container(
                                    width: 170,
                                    height: 225,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(0, 3))
                                        ]),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Image.network(
                                                singleProduct.image[0],
                                                height: 120,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                singleProduct.name,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              height:
                                                  40, // Set chiều cao tối thiểu của Text
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              singleProduct.description,
                                              style: TextStyle(
                                                fontSize: 15,
                                                //  fontWeight: FontWeight.bold
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\đ${NumberFormat("#,###").format(singleProduct.price).toString()}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 20,
                                                )
                                              ],
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                DiscountWidget(
                                  discount: singleProduct.discount,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _onItemTapped(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            activeIcon: Icon(Icons.favorite_outlined),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            activeIcon: Icon(Icons.card_giftcard_outlined),
            label: "Đơn hàng",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person_outline),
            label: "Tài Khoản",
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        currentIndex: 1,
      ),
    );
  }
}

// final List<ProductModel> favoriteList = [
//   ProductModel(
//     image: [
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
//     ],
//     id: "6",
//     name: "lenovo-gaming-legion-5-15iah7h",
//     price: 20000000,
//     description: "hihihi",
//     isFavourite: true,
//     discount: 15,
//     sold: 150,
//   ),
//   ProductModel(
//     image: [
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png",
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png",
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png"
//     ],
//     id: "7",
//     name: "msi-gaming-gf63-thin",
//     price: 21000000,
//     description: "hihihi",
//     isFavourite: false,
//     discount: 15,
//     sold: 150,
//   ),
//   ProductModel(
//     image: [
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png",
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png",
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png"
//     ],
//     id: "1",
//     name: "asus-tuf-gaming-fx506lh-den-2022-dd",
//     price: 22000000,
//     description: "hihihi",
//     isFavourite: false,
//     discount: 15,
//     sold: 150,
//   ),
//   ProductModel(
//     image: [
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
//     ],
//     id: "2",
//     name: "lenovo-gaming-legion-5-15iah7h",
//     price: 20000000,
//     description: "hihihi",
//     isFavourite: true,
//     discount: 15,
//     sold: 150,
//   ),
//   ProductModel(
//     image: [
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png",
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png",
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png"
//     ],
//     id: "3",
//     name: "msi-gaming-gf63-thin",
//     price: 21000000,
//     description: "hihihi",
//     isFavourite: false,
//     discount: 15,
//     sold: 150,
//   ),
//   ProductModel(
//     image: [
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png",
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png",
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png"
//     ],
//     id: "4",
//     name: "asus-tuf-gaming-fx506lh-den-2022-dd",
//     price: 22000000,
//     description: "hihihi",
//     isFavourite: true,
//     discount: 15,
//     sold: 150,
//   ),
//   ProductModel(
//     image: [
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png",
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png",
//       "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png"
//     ],
//     id: "5",
//     name: "asus-tuf-gaming-fx506lh-den-2022-dd",
//     price: 22000000,
//     description: "hihihi",
//     isFavourite: false,
//     discount: 15,
//     sold: 150,
//   ),
//   ProductModel(
//     image: [
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
//       "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
//     ],
//     id: "6",
//     name: "lenovo-gaming-legion-5-15iah7h",
//     price: 20000000,
//     description: "hihihi",
//     isFavourite: true,
//     discount: 15,
//     sold: 150,
//   ),
//   ProductModel(
//     image: [
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png",
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png",
//       "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png"
//     ],
//     id: "7",
//     name: "msi-gaming-gf63-thin",
//     price: 21000000,
//     description: "hihihi",
//     isFavourite: false,
//     discount: 15,
//     sold: 150,
//   ),
// ];
