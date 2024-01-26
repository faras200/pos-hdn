import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_hdn/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

import '../../../core/components/spaces.dart';
import '../../home/bloc/product/product_bloc.dart';
import '../widgets/menu_product_item.dart';
import 'add_product_page.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'List Data Produk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(20.0),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, success: (products) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const SpaceHeight(20.0),
                  itemBuilder: (context, index) => MenuProductItem(
                    data: products[index],
                  ),
                );
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const AddProductPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
