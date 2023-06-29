import 'package:flutter/material.dart';
import 'package:flutter_application_3/Models/category_model/category_model.dart';
import 'package:flutter_application_3/Pages/CategoryView.dart';

class CategoriesWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  CategoriesWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Row(
            children: categories
                .map(
                  (e) => //Signle item
                      InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryView(categoryModel: e),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3))
                            ]),
                        child: Image.network(
                          e.image,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ));
  }
}
