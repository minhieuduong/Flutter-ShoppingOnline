import 'package:flutter/material.dart';
import 'package:flutter_application_3/Firebase/firebase_firestore.dart';
import 'package:flutter_application_3/Models/product_model/product_model.dart';
import 'package:flutter_application_3/Pages/Product_detail.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _GridSearchScreenState();
}

List<ProductModel> productList = [
];

class _GridSearchScreenState extends State<SearchPage> {
  bool isLoading = false;

  List<String> _foundUsers = [];

  @override
  void initState() {
    getCategoryList();
    _foundUsers = productList.map((product) => product.name).toList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productList = await FirebaseFirestoreHelper.instance.getPopular();
    productList.shuffle(); // để sắp xếp lộn xộn list
    setState(() {
      isLoading = false;
    });
  }

  int findIndexByName(String name) {
    return productList.indexWhere((product) => product.name == name);
  }

  void _runFilter(String enteredKeyword) {
    List<String> results = [];
    if (enteredKeyword == "") {
      results = [];
    } else {
      results = productList
          .where((e) =>
              e.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .map((product) => product.name)
          .toList();
    }

    setState(() {
      if (enteredKeyword == "") {
        results = [];
      }
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tìm kiếm',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(index),
                        color: Colors.black,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    product: productList[
                                        findIndexByName(_foundUsers[index])]),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              _foundUsers[index],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      'Trống',
                      style: TextStyle(fontSize: 20),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
