import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Constants/constants.dart';

import 'package:flutter_application_3/Widgets/DiscountWidget.dart';

import 'package:flutter_application_3/provider/app_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/product_model/product_model.dart';

import 'CartPage.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  ProductModel product;

  ProductDetails({required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState(product: product);
}

class _ProductDetailsState extends State<ProductDetails> {
  int _currentIndex = 0;
  // bool _isFavorite = false;
  // ProductModel? _currentProduct;
  ProductModel product;
  _ProductDetailsState({required this.product});
  // List<String> _images = [];

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < product.image.length; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == i ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }

    return indicators;
  }

  void _showDialog(ProductModel product, int value) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    int quantity = 1; // Số lượng mặc định
    double totalprice = 0;

    double totalproduct() {
      totalprice = quantity * product.price;
      return totalprice;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 400,
              height: 500,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value == 1 ? 'Thêm vào giỏ hàng' : 'Mua sản phẩm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Image.network(product.image[0]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Giá: ${NumberFormat("#,###").format(product.price)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                                print(quantity);
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25, bottom: 10),
                          child: Text(
                            "Tổng : ${NumberFormat("#,###").format(totalproduct())} \đ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              if (value == 1) {
                                // Xử lý hành động khi nhấn nút "Thêm"
                                ProductModel productModel =
                                    product.copyWith(qty: quantity);

                                appProvider.addCartProduct(productModel);
                                Navigator.of(context).pop();
                                showMessage("Thêm vào giỏ hàng thành công");
                              } else {
                                // Xử lý hành động khi nhấn nút "Mua"
                                Navigator.of(context).pop();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            child: Text(
                              value == 1 ? 'Thêm' : 'Mua',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 265, top: 5),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductModel product = widget.product;
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 69,
        title: Text(
          'Chi tiết sản phẩm',
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
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 15),
            child: Column(
              children: [
                Container(
                  height: 290,
                  child: PageView.builder(
                    itemCount: product.image.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        product.image[index],
                        width: 150,
                        height: 150,
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: 800,
                    decoration: const BoxDecoration(
                      border: Border(
                        // top: BorderSide(
                        //   color: Colors.grey,
                        //   width: 2,
                        // ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            DiscountWidget(
                              discount: product.discount,
                            ),
                            Text("Giảm giá"),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  // _isFavorite = !_isFavorite;
                                  product.isFavourite = !product.isFavourite;
                                  if (product.isFavourite) {
                                    appProvider.addFavouriteProduct(product);
                                  } else {
                                    appProvider.removeFavouriteProduct(product);
                                  }
                                });
                              },
                              icon: Icon(
                                product.isFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                            Text("Yêu thích"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        width: 320,
                        height: 70,
                        // color: Colors.yellow,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25, bottom: 10),
                      child: Text(
                        "Giá : ${NumberFormat("#,###").format(product.price)} \đ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showDialog(product, 1);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text("Thêm vào giỏ hàng"),
              ),
              ElevatedButton(
                onPressed: () {
                  _showDialog(product, 2);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text("Mua ngay"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
