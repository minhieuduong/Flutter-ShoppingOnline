import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Constants/constants.dart';
import 'package:flutter_application_3/Pages/Product_detail.dart';
import 'package:flutter_application_3/Widgets/DiscountWidget.dart';

import 'package:flutter_application_3/provider/app_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/product_model/product_model.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool selectAll = false; // Trạng thái của checkbox "Chọn tất cả"
  List<bool> itemSelectedList = []; // Trạng thái của checkbox cho từng sản phẩm
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    // Khởi tạo trạng thái ban đầu cho danh sách checkbox sản phẩm
    if (itemSelectedList.isEmpty) {
      itemSelectedList = List.generate(
        appProvider.getCartProductList.length,
        (index) => false,
      );
    }
    // Tính tổng giá trị các checkbox đã chọn
    double totalPrice = 0;
    for (int i = 0; i < appProvider.getCartProductList.length; i++) {
      if (itemSelectedList[i]) {
        totalPrice += appProvider.getCartProductList[i].price *
            (appProvider.getCartProductList[i].qty ?? 1);
      }
      qty = appProvider.getCartProductList[i].qty ?? 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Giỏ hàng",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red, // Đặt màu của mũi tên quay lại
        ),
      ),
      body: itemSelectedList.isEmpty
          ? Center(
              child: Text("Giỏ hàng trống"),
            )
          : ListView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: selectAll,
                              onChanged: (value) {
                                setState(() {
                                  selectAll = value!;
                                  itemSelectedList = List.generate(
                                    appProvider.getCartProductList.length,
                                    (index) => value!,
                                  );
                                });
                              },
                            ),
                            Text("Chọn tất cả"),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 120,
                              ),
                              child: Text(
                                "Đã chọn: ${itemSelectedList.where((item) => item).length}",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: appProvider.getCartProductList.length,
                          itemBuilder: (context, index) {
                            ProductModel singleProduct =
                                appProvider.getCartProductList[index];

                            return Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      child: Container(
                                        width: 380,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                              child: Image.network(
                                                appProvider
                                                    .getCartProductList[index]
                                                    .image[0],
                                                height: 100,
                                                width: 150,
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      appProvider
                                                          .getCartProductList[
                                                              index]
                                                          .name,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    height: 40,
                                                    width: 200,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                  ),
                                                  Text(
                                                    "Pro",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CupertinoButton(
                                                        onPressed: () {
                                                          if (qty > 1) {
                                                            setState(() {
                                                              qty--;
                                                            });
                                                            appProvider.updateQty(
                                                                appProvider
                                                                        .getCartProductList[
                                                                    index],
                                                                qty);
                                                          }
                                                        },
                                                        padding:
                                                            EdgeInsets.zero,
                                                        child:
                                                            const CircleAvatar(
                                                          maxRadius: 13,
                                                          child: Icon(
                                                              Icons.remove),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          // decoration:
                                                          //     BoxDecoration(
                                                          //   color: Colors.black,
                                                          // ),
                                                          child: Text(
                                                            appProvider
                                                                .getCartProductList[
                                                                    index]
                                                                .qty
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          width: 35,
                                                        ),
                                                      ),
                                                      CupertinoButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            qty++;
                                                          });
                                                          appProvider.updateQty(
                                                              appProvider
                                                                      .getCartProductList[
                                                                  index],
                                                              qty);
                                                        },
                                                        padding:
                                                            EdgeInsets.zero,
                                                        child:
                                                            const CircleAvatar(
                                                          maxRadius: 13,
                                                          child:
                                                              Icon(Icons.add),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 0),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Total:",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: Text(
                                                              " ${NumberFormat("#,###").format(appProvider.getCartProductList[index].price * (appProvider.getCartProductList[index].qty ?? 1))} \đ",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.red,
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
                                          if (appProvider
                                                  .getCartProductList[index]
                                                  .discount !=
                                              0)
                                            DiscountWidget(
                                              discount: singleProduct.discount,
                                            ),
                                          Checkbox(
                                            value: itemSelectedList[index],
                                            onChanged: (value) {
                                              // print(qty);
                                              setState(() {
                                                itemSelectedList[index] =
                                                    value!;
                                              });
                                            },
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
                                            builder: (context) =>
                                                ProductDetails(
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
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        appProvider.removeCartProduct(
                                            appProvider
                                                .getCartProductList[index]);
                                        showMessage("Xóa thành công");
                                      },
                                      child: const CircleAvatar(
                                        maxRadius: 13,
                                        child: Icon(
                                          Icons.delete,
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Tổng:",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${NumberFormat("#,###").format(totalPrice)}\đ",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
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
