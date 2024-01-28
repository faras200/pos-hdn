import 'package:pos_hdn/data/datasources/config_db_local.dart';
import 'package:pos_hdn/data/models/response/product_response_model.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();
  static final ProductLocalDatasource instance = ProductLocalDatasource._init();
  static final ConfigDbLocal instanceDb = ConfigDbLocal();

  final String tableProducts = instanceDb.tableProducts;

  //remove all data product
  Future<void> removeAllProducts() async {
    final db = await instanceDb.database;
    await db.delete(tableProducts);
  }

  //insert list data product
  Future<void> insertAllProduct(List<Product> products) async {
    final db = await instanceDb.database;
    for (var product in products) {
      await db.insert(tableProducts, product.toLocalMap());
    }
  }

  //insert data product
  Future<Product> insertProduct(Product product) async {
    final db = await instanceDb.database;
    int id = await db.insert(tableProducts, product.toMap());

    return product.copyWith(id: id);
  }

  //get product
  Future<List<Product>> getAllProduct() async {
    final db = await instanceDb.database;
    final result = await db.query(tableProducts);

    return result.map((e) => Product.fromMapLocal(e)).toList();
  }

  //get product by id
  Future<List<Product>> getProductById(productId) async {
    final db = await instanceDb.database;
    final result = await db.query(tableProducts,
        where: 'product_id = $productId', limit: 1);

    return result.map((e) => Product.fromMapLocal(e)).toList();
  }
}
