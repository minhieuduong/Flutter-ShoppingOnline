import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.isFavourite,
    required this.discount,
    required this.sold,
    this.qty,
  });

  List<String> image;
  String id;
  bool isFavourite;
  String name;
  double price;
  String description;
  int discount;
  int sold;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: List<String>.from(json["image"].map((x) => x)),
        isFavourite: false,
        sold: json["sold"],
        discount: json["discount"],
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "discount": discount,
        "isFavourite": isFavourite,
        "price": price,
        "sold": sold
      };
  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
          id: id,
          name: name,
          description: description,
          image: image,
          discount: discount,
          isFavourite: isFavourite,
          qty: qty ?? this.qty,
          price: price,
          sold: sold);
}
