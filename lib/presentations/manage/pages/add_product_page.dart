import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/core/extensions/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:pos_hdn/data/models/response/product_response_model.dart';
import 'package:pos_hdn/presentations/home/bloc/product/product_bloc.dart';
import 'package:pos_hdn/presentations/manage/models/category_product.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_dropdown.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/image_picker_widget.dart';
import '../../../core/components/spaces.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? stockController;
  TextEditingController? categoryController;

  File? imageFile;
  bool isBestSeller = false;

  @override
  void initState() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    stockController = TextEditingController();
    categoryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
    priceController!.dispose();
    stockController!.dispose();
    categoryController!.dispose();
    super.dispose();
  }

  final List<CategoryProductModels> categories = [
    CategoryProductModels(name: 'Dailymeal', value: '1'),
    CategoryProductModels(name: 'Beras Topi Koki', value: '2'),
    CategoryProductModels(name: 'Bundling', value: '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextField(
            controller: nameController!,
            label: 'Nama Produk',
          ),
          const SpaceHeight(20.0),
          CustomTextField(
            controller: priceController!,
            label: 'Harga Produk',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // final int priceValue = value.toIntegerFromText;
              // priceController.text = priceValue.currencyFormatRp;
              // priceController.selection = TextSelection.fromPosition(
              //     TextPosition(offset: priceController.text.length));
            },
          ),
          const SpaceHeight(20.0),
          ImagePickerWidget(
            label: 'Foto Produk',
            onChanged: (file) {
              if (file == null) {}
              imageFile = file;
            },
          ),
          const SpaceHeight(20.0),
          CustomTextField(
            controller: stockController!,
            label: 'Stok Produk',
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(20.0),
          CustomDropdown<CategoryProductModels>(
            value: categories.first,
            items: categories,
            label: 'Kategori',
            onChanged: (value) {
              categoryController!.text = value!.value;
            },
          ),
          const SpaceHeight(24.0),
          Button.filled(
            onPressed: () {
              final String name = nameController!.text;
              final String price = priceController!.text;
              final int category = categoryController!.text.toIntegerFromText;
              final int stock = stockController!.text.toIntegerFromText;
              final Product product = Product(
                name: name,
                harga: price,
                typeId: category,
                image: imageFile!.absolute.path,
                isBestSeller: isBestSeller,
              );
              context.read<ProductBloc>().add(ProductEvent.addProduct(product));
            },
            label: 'Simpan',
          ),
          const SpaceHeight(30.0),
        ],
      ),
    );
  }
}
