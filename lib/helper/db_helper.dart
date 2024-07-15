import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _obj = DbHelper._helper();

  DbHelper._helper();

  final dbname = 'quotes.db';

  factory DbHelper() {
    return _obj;
  }

  static DbHelper get instance => _obj;

  Database? database;

  Future<void> initDb() async {
    database = await openDatabase(
      dbname,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE "Favorite" ('
              '"id" INTEGER, '
              '"favquotes" TEXT NOT NULL, '
              '"category" TEXT NOT NULL, '
              '"date" NUMERIC NOT NULL, '
              '"image" TEXT , '
              'PRIMARY KEY("id" AUTOINCREMENT))',
        );
      },
      singleInstance: true,
    );
  }

  Future<void> insertFavorite(String quote, String category, {String? image}) async {
    var db = await openDatabase(dbname);
    List<Map<String, dynamic>> result = await db.query(
      'Favorite',
      where: 'favquotes = ? AND category = ?',
      whereArgs: [quote, category],
    );

    if (result.isEmpty) {
      await db.insert(
        'Favorite',
        {
          'favquotes': quote,
          'date': DateTime.now().toString(),
          'category': category,
          'image': image,
        },
      );
    } else {
      print('Quote already exists in the database');
    }
  }


  Future<void> removeFavorite(String id) async {
    var db = await openDatabase(dbname);
    await db.delete('Favorite', where: 'id = ?', whereArgs: [id]);
    db.close();
  }

  Future<List<Map<String, Object?>>> getquotes() async {
    var db = await openDatabase(dbname);
    return await db.query('Favorite');
  }

  Future<bool> checkquote(String quote) async {
    var db = await openDatabase(dbname);
    List<Map> result = await db.query('Favorite', where: 'favquotes = ?', whereArgs: [quote]);
    return result.isNotEmpty;
  }
}