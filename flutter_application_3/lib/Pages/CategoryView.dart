import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Firebase/firebase_firestore.dart';
import 'package:flutter_application_3/Models/category_model/category_model.dart';
import 'package:flutter_application_3/Models/product_model/product_model.dart';
import 'package:flutter_application_3/Pages/CartPage.dart';
import 'package:flutter_application_3/Pages/Product_detail.dart';
import 'package:flutter_application_3/Widgets/DiscountWidget.dart';
import 'package:intl/intl.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  bool isLoading = false;
  List<ProductModel> categoryview = [];
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoryview = await FirebaseFirestoreHelper.instance
        .getCategoryView(widget.categoryModel.id);
    categoryview.shuffle;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 69,
          title: Text(
            widget.categoryModel.name,
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
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: categoryview.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.77,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct = categoryview[index];
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
                                            Icons.favorite_border,
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
              )

        // : SingleChildScrollView(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const SizedBox(height: kToolbarHeight * 1),
        //         Padding(
        //           padding: const EdgeInsets.all(12.0),
        //           child: Row(
        //             children: [
        //               const BackButton(),
        //               Text(
        //                 widget.categoryModel.name,
        //                 style: const TextStyle(
        //                   fontSize: 18.0,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         categoryview.isEmpty
        //             ? const Center(
        //                 child: Text("Best Product is empty"),
        //               )
        //             : Padding(
        //                 padding: const EdgeInsets.all(12.0),
        //                 child: GridView.builder(
        //                     padding: EdgeInsets.zero,
        //                     shrinkWrap: true,
        //                     primary: false,
        //                     itemCount: categoryview.length,
        //                     gridDelegate:
        //                         const SliverGridDelegateWithFixedCrossAxisCount(
        //                             mainAxisSpacing: 20,
        //                             crossAxisSpacing: 20,
        //                             childAspectRatio: 0.7,
        //                             crossAxisCount: 2),
        //                     itemBuilder: (ctx, index) {
        //                       ProductModel singleProduct =
        //                           categoryview[index];
        //                       return Container(
        //                         decoration: BoxDecoration(
        //                           color: Theme.of(context)
        //                               .primaryColor
        //                               .withOpacity(0.3),
        //                           borderRadius: BorderRadius.circular(8.0),
        //                         ),
        //                         child: Column(
        //                           children: [
        //                             const SizedBox(
        //                               height: 12.0,
        //                             ),
        //                             Image.network(
        //                               singleProduct.image[0],
        //                               height: 100,
        //                               width: 100,
        //                             ),
        //                             const SizedBox(
        //                               height: 12.0,
        //                             ),
        //                             Text(
        //                               singleProduct.name,
        //                               style: const TextStyle(
        //                                 fontSize: 18.0,
        //                                 fontWeight: FontWeight.bold,
        //                               ),
        //                             ),
        //                             Text("Price: \$${singleProduct.price}"),
        //                             const SizedBox(
        //                               height: 30.0,
        //                             ),
        //                             SizedBox(
        //                               height: 45,
        //                               width: 140,
        //                               child: OutlinedButton(
        //                                 onPressed: () {
        //                                   Navigator.push(
        //                                     context,
        //                                     MaterialPageRoute(
        //                                       builder: (context) =>
        //                                           ProductDetails(
        //                                               product: singleProduct),
        //                                     ),
        //                                   );
        //                                 },
        //                                 child: const Text(
        //                                   "Buy",
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       );
        //                     }),
        //               ),
        //         const SizedBox(
        //           height: 12.0,
        //         ),
        //       ],
        //     ),
        //   ),
        );
  }
}
