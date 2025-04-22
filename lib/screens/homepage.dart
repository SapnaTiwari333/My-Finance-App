import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myfinance/providers/home_page_provider.dart';
import 'package:myfinance/screens/transactions_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  context.read<HomePageProvider>().updateTransactionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: const Center(child: Text("My Finance")),
        backgroundColor: Colors.redAccent.shade100,
      ),*/
      body: Consumer<HomePageProvider>(
        builder: (ctx, provider, _) {

          final transactions = provider.transactions;
          final categoryData=provider.categoryBreakdown;
          final recent=provider.recentTransactions;

          if (transactions.isEmpty) return _buildEmptyState(context);

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 170,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        _buildSummaryCard(
                          title: "Income",
                          amount: provider.income,
                          color: Colors.green,
                        ),
                        _buildSummaryCard(
                          title: "Expense",
                          amount: provider.expense,
                          color: Colors.red,
                        ),
                        _buildSummaryCard(
                          title: "Balance",
                          amount: provider.balance,
                          color: provider.balance >= 0
                              ? Colors.blue
                              : Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
            
            
                // CATEGORY WISE BREAKDOWN with pie chart
            
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text("Category Breakdown",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 300,
                          child: categoryData.isNotEmpty
                              ? PieChart(
                            PieChartData(
                              sections: categoryData.entries.map((entry){
                                final color = Colors.primaries[entry.key.hashCode % Colors.primaries.length];
            
                                return PieChartSectionData(
                                  color: color,
                                  value: entry.value,
                                  title: "${entry.key}\n${entry.value.toStringAsFixed(2)}",
                                  radius: 100,
                                  titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            
                                );
                              }).toList(),
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                            ),
                          )
                              : const Center(child: Text("No Expenses Data")),
                        ),
                      ],
                    ),
                  ),
                ),

                //RECENT TRANSACTIONS

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation:11,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("RECENT TRANSACTIONS",
                                style:TextStyle(
                              fontSize:18,fontWeight:FontWeight.bold
                                ),
                            ),
                          ),

                          SizedBox(
                            height:10,
                          ),

                          ...recent.map((txn){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(txn["category"]),
                                    subtitle: Text(txn["date"]),
                                    trailing: Text("${txn["amount"]}",
                                    style:TextStyle(color:txn["type"]=="Income"?Colors.green:Colors.red,
                                    )
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })

                        ],
                      ),
                    )
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
  }) {
    return SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Card(
          elevation: 11,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style:
                    const TextStyle(fontSize: 18, color: Colors.white)),
                const SizedBox(height: 10),
                Text(
                  "₹${amount.toStringAsFixed(2)}",
                  style:
                  const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pie_chart, size: 100, color: Colors.blueAccent),
          const SizedBox(height: 20),
          const Text(
            "Welcome to MyFinance!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Start adding transactions to see your financial summary.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TransactionPage()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add First Transaction"),
          ),
        ],
      ),
    );
  }

}
