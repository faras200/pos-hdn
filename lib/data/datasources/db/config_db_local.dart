import 'package:sqflite/sqflite.dart';

class ConfigDbLocal {
  ConfigDbLocal();

  final String tableProducts = 'products';
  final String tableOrders = 'orders';
  final String tableOrderItems = 'order_items';
  final String tableDeposits = 'deposits';
  static Database? _database;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProducts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER,
        name TEXT,
        harga INTEGER,
        berat INTEGER,
        image TEXT,
        category TEXT,
        is_best_seller INTEGER,
        is_sync INTEGER DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableOrders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT,
        qris TEXT,
        nominal INTEGER,
        bayar INTEGER,
        payment_method TEXT,
        total_item INTEGER,
        id_kasir INTEGER,
        deposit_id INTEGER,
        nama_kasir TEXT,
        transaction_time TEXT,
        is_sync INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableOrderItems (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_order INTEGER,
        id_product INTEGER,
        quantity INTEGER,
        price INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableDeposits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT,
        qris TEXT,
        amount INTEGER,
        created_at TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pos_hdn.db');

    return _database!;
  }
}
