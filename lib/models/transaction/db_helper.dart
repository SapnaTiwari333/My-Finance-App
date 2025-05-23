import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  // Singleton pattern
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();

  //  Variables for the transactions table
  static const String TABLE_TRANSACTION = "transactions";  // Updated table name
  static const String COLUMN_TRANSACTION_SNO = "s_no";
  static const String COLUMN_TRANSACTION_TITLE = "title";
  static const String COLUMN_TRANSACTION_AMOUNT = "amount";
  static const String COLUMN_TRANSACTION_TYPE = "transaction_type";
  static const String COLUMN_TRANSACTION_CATEGORY = "category";
  static const String COLUMN_TRANSACTION_DATE = "date";

  Database? myDb;  // Database instance

  //  Get or initialize the database
  Future<Database> getDB() async {
    myDb ??= await openDB();
    return myDb!;
  }

  //  Open the database and create the table if it doesn't exist
  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "transactionDb.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        // Create transactions table
        await db.execute('''
          CREATE TABLE $TABLE_TRANSACTION (
            $COLUMN_TRANSACTION_SNO INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_TRANSACTION_TITLE TEXT,
            $COLUMN_TRANSACTION_AMOUNT TEXT,
            $COLUMN_TRANSACTION_TYPE TEXT,
            $COLUMN_TRANSACTION_CATEGORY TEXT,
            $COLUMN_TRANSACTION_DATE TEXT
          )
        ''');
      },
    );
  }

  // Insert Transaction
  Future<bool> addTransaction({
    required String mTitle,
    required String mAmount,
    required String mType,
    required String mCategory,
    required String mDate,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.insert(
      TABLE_TRANSACTION,
      {
        COLUMN_TRANSACTION_TITLE:mTitle ,
        COLUMN_TRANSACTION_AMOUNT:mAmount ,
        COLUMN_TRANSACTION_TYPE: mType,
        COLUMN_TRANSACTION_CATEGORY: mCategory,
        COLUMN_TRANSACTION_DATE: mDate,
      },
    );
    return rowsEffected > 0;
  }

  // Fetch All Transactions
  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    var db = await getDB();

    //select*from transaction
    List<Map<String,dynamic>>mData=await db.query(TABLE_TRANSACTION);
    return mData;
  }

  // Update Transaction
  Future<bool> updateTransaction({
    required int sno,
    required String mTitle,
    required String mAmount,
    required String mType,
    required String mCategory,
    required String mDate,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.update(
      TABLE_TRANSACTION,
      {
        COLUMN_TRANSACTION_TITLE:mTitle ,
        COLUMN_TRANSACTION_AMOUNT:mAmount ,
        COLUMN_TRANSACTION_TYPE: mType,
        COLUMN_TRANSACTION_CATEGORY: mCategory,
        COLUMN_TRANSACTION_DATE: mDate,
      },
      where: "$COLUMN_TRANSACTION_SNO = $sno");
    return rowsEffected > 0;
  }

  //  Delete Transaction
  Future<bool> deleteTransaction({required int sno}) async {
    var db = await getDB();
    int rowsEffected = await db.delete(
      TABLE_TRANSACTION,where: "$COLUMN_TRANSACTION_SNO = ?", whereArgs: ['$sno'],
    );
    return rowsEffected > 0;
  }
}
