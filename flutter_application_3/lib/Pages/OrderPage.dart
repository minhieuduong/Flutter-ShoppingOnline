import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Models/order_model/order_model.dart';
import 'package:flutter_application_3/Models/product_model/product_model.dart';
import 'package:flutter_application_3/Pages/AccountPage.dart';
import 'package:flutter_application_3/Pages/FavoritePage.dart';
import 'package:flutter_application_3/Pages/Product_detail.dart';
import 'package:flutter_application_3/Widgets/DiscountWidget.dart';
import 'package:intl/intl.dart';

import 'CartPage.dart';
import 'HomePage.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // ignore: unused_field
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
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePage(),
        ),
      );
    } else if (index == 2) {
      if (ModalRoute.of(context)?.settings.name == '/') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderPage(),
          ),
        );
      }
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 69,
        title: Text(
          'Danh sách đơn hàng',
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
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderModel.length,
                    itemBuilder: (context, index) {
                      ProductModel singleProduct =
                          orderModel[0].products[index];

                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  width: 380,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          singleProduct.image[0],
                                          height: 100,
                                          width: 150,
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              child: Text(
                                                singleProduct.name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              height: 40,
                                              width: 200,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                            ),
                                            Text(
                                              "Pro",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    // decoration:
                                                    //     BoxDecoration(
                                                    //   color: Colors.black,
                                                    // ),
                                                    child: Text(
                                                      (singleProduct.qty != null
                                                          ? singleProduct.qty
                                                              .toString()
                                                          : '1'),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    width: 35,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 0),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Total:",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(
                                                        " ${NumberFormat("#,###").format(singleProduct.price * (singleProduct.qty ?? 1))} \đ",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                width: 200,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: Column(
                                  children: [
                                    if (singleProduct.discount != 0)
                                      DiscountWidget(
                                        discount: singleProduct.discount,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          product: singleProduct),
                                    ),
                                  );
                                },
                                child: const CircleAvatar(
                                  maxRadius: 13,
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
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
        currentIndex: 2,
      ),
    );
  }
}

List<OrderModel> orderModel = [
  OrderModel(
    orderId: "12783178",
    products: [
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
    ],
    status: "pending",
    totalPrice: 200000000,
  ),
  OrderModel(
    orderId: "12783178",
    products: [
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
    ],
    status: "pending",
    totalPrice: 200000000,
  ),
  OrderModel(
    orderId: "12783178",
    products: [
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
      ProductModel(
        image: [
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png",
          "assets/images/lenovo-gaming-legion-5-15iah7h-xam-dam-dd.png"
        ],
        id: "6",
        name: "lenovo-gaming-legion-5-15iah7h",
        price: 20000000,
        description: "hihihi",
        isFavourite: true,
        discount: 15,
        sold: 150,
      ),
    ],
    status: "pending",
    totalPrice: 200000000,
  ),
];
