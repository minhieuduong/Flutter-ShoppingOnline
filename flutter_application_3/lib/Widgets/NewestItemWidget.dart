import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../Models/product_model/product_model.dart';
import '../Pages/Product_detail.dart';
import 'DiscountWidget.dart';

class NewestItemWidget extends StatelessWidget {
  final List<ProductModel> newest;

  const NewestItemWidget({super.key, required this.newest});
  @override
  Widget build(BuildContext context) {
    return newest.isEmpty
        ? Center(
            child: Text("Không load được dữ liệu"),
          )
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 50),
              shrinkWrap: true,
              primary: false,
              itemCount: newest.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 0.77,
                  crossAxisCount: 2),
              itemBuilder: (ctx, index) {
                ProductModel singleProduct = newest[index];
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\đ${NumberFormat("#,###").format(singleProduct.price).toString()}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        singleProduct.isFavourite
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
                      if (singleProduct.discount != 0)
                        DiscountWidget(
                          discount: singleProduct.discount,
                        ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}


//---------------
// Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 7),
//                   child: Container(
//                     width: 170,
//                     height: 225,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 3,
//                               blurRadius: 10,
//                               offset: Offset(0, 3))
//                         ]),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               alignment: Alignment.center,
//                               child: Image.asset(
//                                 singleProduct.image,
//                                 height: 120,
//                               ),
//                             ),
//                             Container(
//                               child: Text(
//                                 singleProduct.name,
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 maxLines: 2,
//                               ),
//                               height: 40, // Set chiều cao tối thiểu của Text
//                             ),
//                             const SizedBox(
//                               height: 4,
//                             ),
//                             Text(
//                               singleProduct.description,
//                               style: TextStyle(
//                                 fontSize: 15,

//                                 //  fontWeight: FontWeight.bold
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "\đ${NumberFormat("#,###").format(singleProduct.price).toString()}",
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Icon(
//                                   Icons.favorite_border,
//                                   color: Colors.red,
//                                   size: 20,
//                                 )
//                               ],
//                             )
//                           ]),
//                     ),
//                   ),
//                 ),
//                 DiscountWidget(),
//               ],
//             )