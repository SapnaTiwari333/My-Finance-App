import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:myfinance/models/transaction/db_helper.dart';
import 'package:myfinance/screens/transactions_page.dart';

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
  List<Map<String, dynamic>> allTransactions = [];
  Map<String, double> categoryData = {};

  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double netBalance = 0.0;

  final dbRef = DBHelper.getInstance;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  // ✅ Fetch transactions and calculate balance and category data
  Future<void> fetchTransactions() async {
    try {
      allTransactions = await dbRef.getAllTransactions();

      totalIncome = 0.0;
      totalExpense = 0.0;
      categoryData.clear();

      for (var txn in allTransactions) {
        double amount = double.parse(txn[DBHelper.COLUMN_TRANSACTION_AMOUNT]);
        String category = txn[DBHelper.COLUMN_TRANSACTION_CATEGORY];

        if (txn[DBHelper.COLUMN_TRANSACTION_TYPE] == 'Income') {
          totalIncome += amount;
        } else {
          totalExpense += amount;

          // Calculate category-wise expense
          if (categoryData.containsKey(category)) {
            categoryData[category] = categoryData[category]! + amount;
          } else {
            categoryData[category] = amount;
          }
        }
      }

      netBalance = totalIncome - totalExpense;

      setState(() {}); // Refresh UI
    } catch (e) {
      print("Error fetching transactions: $e");
    }
  }

  // 📅 Format date for display
  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = allTransactions.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("My Finance")),
        backgroundColor: Colors.redAccent.shade100,
      ),
      body: isEmpty ? buildEmptyState() : buildDashboard(),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TransactionPage()),
          ).then((_) => fetchTransactions());
        },
        label: const Text("Add Transaction"),
        icon: const Icon(Icons.add),
      ),*/
    );
  }

  // ✅ Empty state UI for first-time users
  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pie_chart, size: 100, color: Colors.blueAccent),
          const SizedBox(height: 20),
          const Text(
            "🎉 Welcome to MyFinance!",
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
                MaterialPageRoute(builder: (context) => const TransactionPage()),
              ).then((_) => fetchTransactions());
            },
            icon: const Icon(Icons.add),
            label: const Text("Add First Transaction"),
          ),
        ],
      ),
    );
  }

  // ✅ Dashboard with Pie Chart and transaction summary
  Widget buildDashboard() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Top Summary Cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSummaryCard("💰 Income", "₹${totalIncome.toStringAsFixed(2)}", Colors.green),
              buildSummaryCard("💸 Expense", "₹${totalExpense.toStringAsFixed(2)}", Colors.red),
              buildSummaryCard("🔥 Balance", "₹${netBalance.toStringAsFixed(2)}",
                  netBalance >= 0 ? Colors.blue : Colors.redAccent),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 📊 Category Breakdown with Pie Chart
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("📊 Category Breakdown",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: categoryData.isNotEmpty
                      ? PieChart(
                    PieChartData(
                      sections: categoryData.entries.map((entry) {
                        final color = Colors.primaries[entry.key.hashCode % Colors.primaries.length];
                        return PieChartSectionData(
                          color: color,
                          value: entry.value,
                          title: "${entry.key}\n₹${entry.value.toStringAsFixed(2)}",
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

        const SizedBox(height: 20),

        // 🔥 Recent Transactions
        const Text("🔥 Recent Transactions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

        ...allTransactions.take(5).map((txn) {
          bool isIncome = txn[DBHelper.COLUMN_TRANSACTION_TYPE] == 'Income';
          return Card(
            elevation: 3,
            child: ListTile(
              leading: Icon(
                isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                color: isIncome ? Colors.green : Colors.red,
              ),
              title: Text(txn[DBHelper.COLUMN_TRANSACTION_TITLE]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Amount: ₹${txn[DBHelper.COLUMN_TRANSACTION_AMOUNT]}"),
                  Text("Category: ${txn[DBHelper.COLUMN_TRANSACTION_CATEGORY]}"),
                  Text("Date: ${formatDate(txn[DBHelper.COLUMN_TRANSACTION_DATE])}"),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  // ✅ Summary card widget
  Widget buildSummaryCard(String title, String amount, Color color) {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
            Text(amount,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
