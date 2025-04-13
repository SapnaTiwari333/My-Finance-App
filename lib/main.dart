import "package:flutter/material.dart";
import "package:myfinance/models/transaction/db_helper.dart";
import "package:myfinance/providers/category_provider.dart";
import "package:myfinance/providers/home_page_provider.dart";
import "package:myfinance/providers/transaction_provider.dart";
import "package:myfinance/screens/dashboard_screen.dart";
import "package:myfinance/models/category/db_helper_category.dart";


import "package:provider/provider.dart";


void main() async{
  WidgetsFlutterBinding.ensureInitialized();//Ensure DB initialized before starting
  runApp(MultiProvider
    (providers: [
      ChangeNotifierProvider(
    create: (context)=> TransactionProvider(dbHelper: DBHelper.getInstance),
  ),
    ChangeNotifierProvider(create: (context)=>CategoryProvider(dbHelper: DbHelperCategory.getInstance)
    ),
    ChangeNotifierProvider(
      create:(context)=>HomePageProvider(dbHelper: DBHelper.getInstance),
    )
  ],
  child:FinanceApp(),
  ));
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyFinance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const DashboardScreen(),
    );
  }
}