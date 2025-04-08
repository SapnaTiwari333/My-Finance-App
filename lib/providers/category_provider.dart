import "package:flutter/material.dart";
import "package:myfinance/models/category/db_helper_category.dart";


class CategoryProvider extends ChangeNotifier{
  DbHelperCategory  dbHelper;
  CategoryProvider({required this.dbHelper});
  List<Map<String,dynamic>>_mData=[];

  //events

  void addCategory(String title,String type,String desc) async{
    bool check=await dbHelper.addCategory(
        mName: title, mCategoryType: type, mDescription: desc);
    if(check){
      _mData=await dbHelper.getAllCategories();
      notifyListeners();
    }
  }

  void updateCategory(int sno,String title,String type,String desc) async{
    bool check=await dbHelper.updateCategory(
        sno: sno, mName:title,
        mCategoryType: type, mDescription: desc);
    if(check){
      _mData=await dbHelper.getAllCategories();
      notifyListeners();
    }
  }

  void deleteCategory(int sno) async{
    bool check=await dbHelper.deleteCategory(sno: sno);
    if(check){
      _mData=await dbHelper.getAllCategories();
      notifyListeners();
    }
  }

  List<Map<String,dynamic>> getCategory()=>_mData;
  Future<void> getInitialCategory() async{
    _mData=await dbHelper.getAllCategories();
    notifyListeners();
  }
}