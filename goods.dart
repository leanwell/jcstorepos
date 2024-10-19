import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Product {
  final String name;
  double price;
  final int quantity; 

  Product({required this.name, required this.price, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
class GoodsDBHelper {
  static final GoodsDBHelper _instance = GoodsDBHelper._internal();
  static Database? _database;

  factory GoodsDBHelper() {
    return _instance;
  }

  GoodsDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'goods.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE goods (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert(
      'goods',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('goods');

    return List.generate(maps.length, (i) {
      return Product(
        name: maps[i]['name'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  Future<void> updateProductPrice(String name, double newPrice) async {
    final db = await database;
    await db.update(
      'goods',
      {'price': newPrice},
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> updateProductQuantity(String name, int newQuantity) async {
    final db = await database;
    await db.update(
      'goods',
      {'quantity': newQuantity},
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> removeProduct(String name) async {
    final db = await database;
    await db.delete('goods', where: 'name = ?', whereArgs: [name]);
  }
}