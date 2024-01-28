import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/data/datasources/auth_local_datasource.dart';
import 'package:pos_hdn/data/models/response/auth_response_model.dart';
import 'package:pos_hdn/presentations/home/bloc/product/product_bloc.dart';
import 'package:pos_hdn/presentations/manage/pages/settings_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/search_input.dart';
import '../../../core/components/spaces.dart';
import '../widgets/product_card.dart';
import '../widgets/product_empty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final indexValue = ValueNotifier(0);
  dynamic dataUser = false;
  late final AuthResponseModel getData;
  final log = Logger();
  String userName = '';
  Future<void> getDataUser() async {
    getData = (await AuthLocalDatasource().getAuthData())!;
  }

  late int category = 0;
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const ProductEvent.fetchLocal());
    getDataUser();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        dataUser = getData;
      });
    });
  }

  void onCategoryTap(int index) {
    searchController.clear();
    indexValue.value = index;

    switch (index) {
      case 0:
      case 1:
      case 2:
      case 3:
        category = index;
        break;
      default:
        category = 0; // Default category, bisa disesuaikan sesuai kebutuhan
        break;
    }
    context.read<ProductBloc>().add(ProductEvent.fetchByCategory(category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
          ),
          child: AppBarContent(
            username: dataUser == false ? "" : dataUser.data.user.name,
            location: 'oke',
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SearchInput(
                textCari: 'Cari produk di sini',
                controller: searchController,
                onChanged: (value) {
                  if (value.length > 3) {
                    context
                        .read<ProductBloc>()
                        .add(ProductEvent.searchProduct(value));
                  }
                  if (value.isEmpty) {
                    context
                        .read<ProductBloc>()
                        .add(const ProductEvent.fetchAllFromState());
                  }
                },
              ),
              const SpaceHeight(20.0),
              ValueListenableBuilder(
                valueListenable: indexValue,
                builder: (context, value, _) => Row(
                  children: [
                    MenuButton(
                      iconPath: Assets.icons.allCategories.path,
                      label: 'Semua',
                      isActive: value == 0,
                      onPressed: () => onCategoryTap(0),
                    ),
                    const SpaceWidth(10.0),
                    MenuButton(
                      iconPath: Assets.icons.dailymeal.path,
                      label: 'Dailymeal',
                      isActive: value == 1,
                      onPressed: () => onCategoryTap(1),
                    ),
                    const SpaceWidth(10.0),
                    MenuButton(
                      iconPath: Assets.icons.topikoki.path,
                      label: 'Topikoki',
                      isActive: value == 2,
                      onPressed: () => onCategoryTap(2),
                    ),
                    const SpaceWidth(10.0),
                    MenuButton(
                      iconPath: Assets.icons.snack.path,
                      label: 'Bundling',
                      isActive: value == 3,
                      onPressed: () => onCategoryTap(3),
                    ),
                  ],
                ),
              ),
              const SpaceHeight(35.0),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return const SizedBox();
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }, error: (message) {
                    return Center(
                      child: Text(message),
                    );
                  }, success: (products) {
                    if (products.isEmpty) {
                      return const ProductEmpty();
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65,
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        data: products[index],
                        onCartButton: () {},
                      ),
                    );
                  });
                },
              ),
              const SpaceHeight(30.0),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarContent extends StatelessWidget {
  final String username;
  final String location;
  const AppBarContent({
    super.key,
    required this.username,
    required this.location,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.face,
                  size: 20,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
              Text(
                'Hi, $username',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.manage_accounts,
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
