import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelperCategory {

  // Singleton pattern
  DbHelperCategory._();
  static final DbHelperCategory getInstance = DbHelperCategory._();

  //  Variables for the categories table
  static const String TABLE_CATEGORY = "categories";
  static const String COLUMN_CATEGORY_SNO = "s_no";
  static const String COLUMN_CATEGORY_NAME = "name";
  static const String COLUMN_CATEGORY_TYPE = "category_type";    // Expense/Income
  static const String COLUMN_CATEGORY_DESCRIPTION = "description";


  Database? myDb;  // Database instance

  // Get or initialize the database
  Future<Database> getDB() async {
    myDb ??= await openDB();
    return myDb!;
  }

  //  Open the categories database
  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "categoriesDb.db");  // Separate DB for categories

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE $TABLE_CATEGORY (
            $COLUMN_CATEGORY_SNO INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_CATEGORY_NAME TEXT,
            $COLUMN_CATEGORY_TYPE TEXT,
            $COLUMN_CATEGORY_DESCRIPTION TEXT,
           
          )
        ''');
      },
    );
  }

  //  Insert Category
  Future<bool> addCategory({
    required String mName,
    required String mCategoryType,
    required String mDescription,

  }) async {
    var db = await getDB();
    int rowsEffected = await db.insert(
      TABLE_CATEGORY,
      {
        COLUMN_CATEGORY_NAME:mName ,
        COLUMN_CATEGORY_TYPE: mCategoryType,
        COLUMN_CATEGORY_DESCRIPTION: mDescription,

      },
    );
    return rowsEffected > 0;
  }

  //  Fetch All Categories
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    var db = await getDB();
    List<Map<String,dynamic>>mData= await db.query(TABLE_CATEGORY);
    return mData;
  }

  //  Update Category
  Future<bool> updateCategory({
    required int sno,
    required String mName,
    required String mCategoryType,
    required String mDescription,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.update(
      TABLE_CATEGORY,
      {
        COLUMN_CATEGORY_NAME:mName ,
        COLUMN_CATEGORY_TYPE: mCategoryType,
        COLUMN_CATEGORY_DESCRIPTION: mDescription,
      },
      where: "$COLUMN_CATEGORY_SNO = $sno",

    );
    return rowsEffected > 0;
  }

  //  Delete Category
  Future<bool> deleteCategory({required int sno}) async {
    var db = await getDB();
    int rowsEffected = await db.delete(
      TABLE_CATEGORY, where: "$COLUMN_CATEGORY_SNO = ?", whereArgs: ['$sno'],
    );
    return rowsEffected > 0;
  }
}
