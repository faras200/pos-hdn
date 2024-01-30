import 'package:pos_hdn/data/datasources/config_db_local.dart';
import 'package:pos_hdn/data/models/request/order_request_model.dart';
import 'package:pos_hdn/presentations/order/models/order_model.dart';

import '../../presentations/home/models/order_item.dart';

class OrderLocalDatasource {
  OrderLocalDatasource._init();
  static final ConfigDbLocal instanceDb = ConfigDbLocal();
  static final OrderLocalDatasource instance = OrderLocalDatasource._init();

  final String tableOrders = instanceDb.tableOrders;
  final String tableOrderItems = instanceDb.tableOrderItems;
  //save order
  Future<int> saveOrder(OrderModel order) async {
    final db = await instanceDb.database;
    int id = await db.insert(tableOrders, order.toMapForLocal());
    for (var orderItem in order.orders) {
      await db.insert(tableOrderItems, orderItem.toMapForLocal(id));
    }
    return id;
  }

  //get order by isSync = 0
  Future<List<OrderModel>> getOrderByIsSync() async {
    final db = await instanceDb.database;
    final result = await db.query(tableOrders, where: 'is_sync = 0');

    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }

  //get order item by id order local
  Future<List<OrderItemModel>> getOrderItemByOrderIdLocal(int idOrder) async {
    final db = await instanceDb.database;
    final result =
        await db.query(tableOrderItems, where: 'id_order = $idOrder');

    return result.map((e) => OrderItem.fromMapLocal(e)).toList();
  }

  //update isSync order by id
  Future<int> updateIsSyncOrderById(int id) async {
    final db = await instanceDb.database;
    return await db.update(tableOrders, {'is_sync': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  //get all orders
  Future<List<OrderModel>> getAllOrder() async {
    final db = await instanceDb.database;
    final result = await db.query(tableOrders, orderBy: 'id DESC');

    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }

  //get all orders tunai
  Future<List<OrderModel>> getOrderTunai() async {
    final db = await instanceDb.database;
    final result =
        await db.query(tableOrders, where: "payment_method = 'Tunai'");

    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }

  //get order item by id order
  Future<List<OrderItem>> getOrderItemByOrderId(int idOrder) async {
    final db = await instanceDb.database;
    final result = await db.query(tableOrderItems);

    return result.map((e) => OrderItem.fromMap(e)).toList();
  }
}
