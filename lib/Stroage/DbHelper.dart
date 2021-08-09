import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Model/CartModelLocal.dart';


class DbHelper{
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
   DbHelper.internal();
   Database? _db;
  Future<Database?> createDatabase() async{
    if(_db != null){
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'product.db');
    _db = await openDatabase(path,version: 1, onCreate: (Database db, int v){
      //create tables
      db.execute("CREATE TABLE product ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "img TEXT,"
          "category TEXT,"
          "price REAL,"
          "quantity INTEGER"
          ")");
    });
    return _db;
  }
  Future<int> addToCart(CartMedelLocal cartMedelLocal ) async{
    Database? db = await createDatabase();
    //db.rawInsert('insert into courses value')
    return db!.insert('product', cartMedelLocal.toMap());
  }
  Future<List> allProduct2(int select) async{
    Database? db = await createDatabase();
    //db.rawQuery('select * from courses');
    return db!.query('product', where: 'selectItem = ?', whereArgs: [select]);
  }
  Future<List> allProduct() async{
    Database? db = await createDatabase();
    //db.rawQuery('select * from courses');
    return db!.query('product');
  }
  Future<int> deleteCart() async{
    Database? db = await createDatabase();
    return db!.delete('product');
  }
  Future<int> delete(int id) async{
    Database? db = await createDatabase();
    return db!.delete('product', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> delete2(int select) async{
    Database? db = await createDatabase();
    return db!.delete('product', where: 'selectItem = ?', whereArgs: [select]);
  }
  Future<int> updateCourse(CartMedelLocal product) async{
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Database? db = await createDatabase();
    return await db!.update('product', product.toMap(),where: 'id = ?', whereArgs: [product.id]);
  }
  /////////////////////////////////
}