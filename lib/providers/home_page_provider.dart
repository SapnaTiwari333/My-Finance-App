import "package:flutter/material.dart";
import "package:myfinance/models/transaction/db_helper.dart";

class HomePageProvider extends ChangeNotifier {
  final DBHelper dbHelper;

  HomePageProvider({required this.dbHelper});

  List<Map<String, dynamic>> _mData = [];
  Map<String,dynamic> _categoryData={};

  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  double _netBalance = 0.0;

  /// Fetches transactions & calculates totals
  Future<void> loadTransactionsAndSummary() async {
    _totalIncome = 0.0;
    _totalExpense = 0.0;

    _mData = await dbHelper.getAllTransactions();

    for (var tnx in _mData) {
      double amount = double.tryParse(
          tnx[DBHelper.COLUMN_TRANSACTION_AMOUNT].toString()) ??
          0;

      if (tnx[DBHelper.COLUMN_TRANSACTION_TYPE] == "Income") {
        _totalIncome += amount;
      } else {
        _totalExpense += amount;
      }
    }

    _netBalance = _totalIncome - _totalExpense;
    notifyListeners();
  }

  //CALCULATING CATEGORY WISE AMOUNT

  Future<void> categoryWiseCalculation() async{
    _categoryData.clear();

    _mData=await dbHelper.getAllTransactions();

    for(var txn in _mData){
      double amount=double.parse(txn[DBHelper.COLUMN_TRANSACTION_AMOUNT]);
      String category=txn[DBHelper.COLUMN_TRANSACTION_CATEGORY];


      if(txn[DBHelper.COLUMN_TRANSACTION_TYPE]=="Expense"){
        if(_categoryData.containsKey(category)){
          _categoryData[category]=_categoryData[category]!+amount;
        }else{
          _categoryData[category]=amount;
        }
      }


    }
  }

  // Add this method to handle transaction updates
  Future<void> updateTransactionData() async {
    await loadTransactionsAndSummary();
    await categoryWiseCalculation();
  }


  // Public Getters
  List<Map<String, dynamic>> get transactions => _mData;
  Map<String,dynamic> get categoryBreakdown=> _categoryData;
  List<Map<String, dynamic>> get recentTransactions => _mData.take(5).toList();

  double get income => _totalIncome;
  double get expense => _totalExpense;
  double get balance => _netBalance;

}