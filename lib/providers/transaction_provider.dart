import "package:flutter/material.dart";
import "package:myfinance/models/transaction/db_helper.dart";

class TransactionProvider extends ChangeNotifier{
  DBHelper dbHelper;
  TransactionProvider({required this.dbHelper}); //constructor
  List<Map<String,dynamic>>_mData=[];



  //events
 void addTransactions(String title,dynamic amount,String type,String category,String date) async{
   bool check=await dbHelper.addTransaction(mTitle: title,
       mAmount: amount,
       mType: type,
       mCategory: category,
       mDate: date);
   if(check){
     _mData=await dbHelper.getAllTransactions();
     notifyListeners();
   }
 }

  void updateTransactions(String title,dynamic amount,String type,String category,String date,int sno) async{
    bool check=await dbHelper.updateTransaction(mTitle: title,
        mAmount: amount,
        mType: type,
        mCategory: category,
        mDate: date,
        sno: sno,
    );
    if(check){
      _mData=await dbHelper.getAllTransactions();
      notifyListeners();
    }
  }
  void deleteTransaction(int sno) async{
   bool check=await dbHelper.deleteTransaction(sno: sno);
   if(check){
     _mData=await dbHelper.getAllTransactions();
     notifyListeners();
   }
  }


  List<Map<String,dynamic>> getTransactions()=>_mData;

  Future<void> getInitialTransactions() async{
    _mData=await dbHelper.getAllTransactions();
    notifyListeners();
  }

}