// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:image_picker/image_picker.dart';

class ProductRequestModel {
  final String name;
  final int price;
  final String category;
  final int isBestSeller;
  final XFile image;

  ProductRequestModel({
    required this.name,
    required this.price,
    required this.category,
    required this.isBestSeller,
    required this.image,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'price': price.toString(),
      'category': category,
      'isBestSeller': isBestSeller.toString(),
    };
  }
}
