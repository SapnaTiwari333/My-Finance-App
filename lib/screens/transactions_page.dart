import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance/models/transaction/db_helper.dart';
void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyFinance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const TransactionPage(),
    );
  }
}

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {

  List<Map<String, dynamic>> allTransactions = [];
  DBHelper? dbRef;  // DBHelper instance

  // Form Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String transactionType = 'Income';  // Default type

  @override
  void initState() {
    super.initState();
    dbRef = DBHelper.getInstance;  // Initialize DBHelper
    getTransactions();
  }

  // ✅ Fetch All Transactions
  void getTransactions() async {
    allTransactions = await dbRef!.getAllTransactions();
    setState(() {});
  }

  // 📅 Date Picker
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Center(
          child: Text(
            'TRANSACTIONS',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: allTransactions.isNotEmpty
          ? ListView.builder(
        itemCount: allTransactions.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: Text('${index + 1}'),
            title: Text(allTransactions[index][DBHelper.COLUMN_TRANSACTION_TITLE]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount: ₹${allTransactions[index][DBHelper.COLUMN_TRANSACTION_AMOUNT]}'),
                Text('Type: ${allTransactions[index][DBHelper.COLUMN_TRANSACTION_TYPE]}'),
                Text('Category: ${allTransactions[index][DBHelper.COLUMN_TRANSACTION_CATEGORY]}'),
                Text('Date: ${allTransactions[index][DBHelper.COLUMN_TRANSACTION_DATE]}'),
              ],
            ),
            trailing: SizedBox(
              width: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // Pre-fill data for update
                      titleController.text = allTransactions[index][DBHelper.COLUMN_TRANSACTION_TITLE];
                      amountController.text = allTransactions[index][DBHelper.COLUMN_TRANSACTION_AMOUNT].toString();
                      categoryController.text = allTransactions[index][DBHelper.COLUMN_TRANSACTION_CATEGORY];
                      dateController.text = allTransactions[index][DBHelper.COLUMN_TRANSACTION_DATE];
                      transactionType = allTransactions[index][DBHelper.COLUMN_TRANSACTION_TYPE];

                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return getBottomSheetWidget(
                            isUpdate: true,
                            sno: allTransactions[index][DBHelper.COLUMN_TRANSACTION_SNO],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.edit, color: Colors.green),
                  ),
                  InkWell(
                    onTap: () async {
                      bool check = await dbRef!.deleteTransaction(
                        sno: allTransactions[index][DBHelper.COLUMN_TRANSACTION_SNO],
                      );
                      if (check) {
                        getTransactions();
                      }
                    },
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : const Center(child: Text("No Transactions Yet!!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          amountController.clear();
          categoryController.clear();
          dateController.clear();
          transactionType = 'Income';

          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => getBottomSheetWidget(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🔥 Bottom Sheet for Adding/Updating Transactions
  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isUpdate ? "Update Transaction" : "Add Transaction",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Title Field
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter title here",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Amount Field
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount here",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Category Field
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                hintText: "Enter category here",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Transaction Type Dropdown
            DropdownButtonFormField<String>(
              value: transactionType,
              items: ['Income', 'Expense'].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) => setState(() => transactionType = value!),
              decoration: const InputDecoration(labelText: "Transaction Type"),
            ),
            const SizedBox(height: 15),

            // Date Picker Field
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date",
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
              ),
              onTap: () => selectDate(context),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      bool check = isUpdate
                          ? await dbRef!.updateTransaction(
                        sno: sno,
                        title: titleController.text,
                        amount: amountController.text,
                        type: transactionType,
                        category: categoryController.text,
                        date: dateController.text,
                      )
                          : await dbRef!.addTransaction(
                        title: titleController.text,
                        amount: amountController.text,
                        type: transactionType,
                        category: categoryController.text,
                        date: dateController.text,
                      );

                      if (check) {
                        getTransactions();
                      }
                      Navigator.pop(context);
                    },
                    child: Text(isUpdate ? "Update" : "Add"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
