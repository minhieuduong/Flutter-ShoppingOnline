import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Firebase/firebase_firestore.dart';
import 'package:flutter_application_3/Models/category_model/category_model.dart';
import 'package:flutter_application_3/Pages/FavoritePage.dart';
import 'package:flutter_application_3/Pages/OrderPage.dart';
import 'package:flutter_application_3/Pages/AccountPage.dart';
import 'package:flutter_application_3/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../Models/product_model/product_model.dart';

import '../Widgets/HeaderWidget.dart';
import '../Widgets/CategoriesWidget.dart';
import '../Widgets/NewestItemWidget.dart';
import '../Widgets/PopularItemsWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<CategoryModel> categoriesList = [];
List<ProductModel> popularList = [];
List<ProductModel> newestList = [];

class _HomePageState extends State<HomePage> {
  // bool _hideNavBar = false;
  // ignore: unused_field
  int _selectedIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    // AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    // appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    categoriesList.shuffle(); // để sắp xếp lộn xộn list
    popularList = await FirebaseFirestoreHelper.instance.getPopular();
    popularList.shuffle();
    newestList = await FirebaseFirestoreHelper.instance.getNewest();
    newestList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      if (ModalRoute.of(context)?.settings.name == '/') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePage(),
        ),
      );
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
    return MaterialApp(
      home: Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              )
            : CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true, // Để cố định ở trên cùng khi kéo xuống.
                    delegate: FixedHeaderDelegate(
                        child: Container(
                      color: Colors.yellow,
                      child: ListView(
                        children: [
                          HeaderWidget(),
                        ],
                      ),
                    )),
                  ),
                  SliverFillRemaining(
                    child: YourContentWidget(),
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
          currentIndex: 0,
        ),
      ),
    );
  }
}

class FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  FixedHeaderDelegate({required this.child});

  @override
  double get minExtent => 110; // Chiều cao tối thiểu của header.

  @override
  double get maxExtent => 110; // Chiều cao tối đa của header.

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class YourContentWidget extends StatefulWidget {
  const YourContentWidget({super.key});

  @override
  State<YourContentWidget> createState() => _YourContentWidgetState();
}

class _YourContentWidgetState extends State<YourContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Phân loại",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          // Category widget
          CategoriesWidget(
            categories: categoriesList,
          ),
          // Popular Items
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Phổ biến",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          // Popular Items Widget
          PopularItemsWidget(
            popular: popularList,
          ),

          // Newest Items
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Mới nhất",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Newest Items Widget
          NewestItemWidget(newest: newestList),
        ],
      ),
    );
  }
}

// List<String> categoriesList = [
//   "assets/images/laptop.png",
//   "assets/images/tainghe.png",
//   "assets/images/chuot.png",
//   "assets/images/banphim.png",
//   "assets/images/tuichongsoc.png",
//   "assets/images/ram.png",
// ];
// final List<ProductModel> popularItems = [
//   ProductModel(
//     image: "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png",
//     id: "1",
//     name: "asus tuf gaming fx506lh den 2022 đd",
//     price: 22000000,
//     description: "hihihii",
//     status: "pending",
//     isFavourite: false,
//   ),
//   ProductModel(
//     image: "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
//     id: "2",
//     name: "lenovo-gaming-legion-5-15iah7h",
//     price: 20000000,
//     description: "hihihi",
//     status: "pending",
//     isFavourite: true,
//   ),
//   ProductModel(
//     image: "assets/images/msi-gaming-gf63-thin-11uc-den-dd.png",
//     id: "3",
//     name: "msi-gaming-gf63-thin",
//     price: 21000000,
//     description: "hihihi",
//     status: "pending",
//     isFavourite: false,
//   ),
//   ProductModel(
//     image: "assets/images/asus-tuf-gaming-fx506lh-den-2022-dd.png",
//     id: "4",
//     name: "asus-tuf-gaming-fx506lh-den-2022-dd",
//     price: 22000000,
//     description: "hihihi",
//     status: "pending",
//     isFavourite: true,
//   )
// ];
// final List<ProductModel> newItems = [
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
