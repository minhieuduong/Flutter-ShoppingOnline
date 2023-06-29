import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Pages/Product_detail.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_3/Models/product_model/product_model.dart';

import 'DiscountWidget.dart';

class PopularItemsWidget extends StatelessWidget {
  final List<ProductModel> popular;
  PopularItemsWidget({super.key, required this.popular});
  @override
  Widget build(BuildContext context) {
    return popular.isEmpty
        ? Center(
            child: Text("Không load được dữ liệu"),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: Row(
                children: popular.map((e) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(product: e),
                        ),
                      );
                    },
                    child: //Single Item

                        Stack(
                      //
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
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(0, 3))
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        e.image[0],
                                        height: 120,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        e.name,
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
                                      e.description,
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\đ${NumberFormat("#,###").format(e.price).toString()}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          e.isFavourite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                          size: 20,
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        if (e.discount != 0)
                          DiscountWidget(
                            discount: e.discount,
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
