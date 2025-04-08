import 'package:flutter/material.dart';
import 'package:myfinance/models/transaction/db_helper.dart';
import 'package:myfinance/providers/transaction_provider.dart';
import 'package:myfinance/screens/add_transaction.dart';
import 'package:provider/provider.dart';



class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {

  //List<Map<String, dynamic>> allTransactions = [];
 // DBHelper? dbRef=; // DBHelper instance


  @override
  void initState() {
    super.initState();
    context.read<TransactionProvider>().getInitialTransactions();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade100,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'TRANSACTIONS',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,letterSpacing:0.8),
            ),
          ),
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (ctx, provider, __) {
          List<Map<String,dynamic>>allTransactions=provider.getTransactions();
          return allTransactions.isNotEmpty
              ? ListView.builder(
            itemCount: allTransactions.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 11,
                  child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(allTransactions[index][DBHelper.COLUMN_TRANSACTION_TITLE],
                        style: TextStyle(
                            fontSize:18,fontWeight:FontWeight.bold
                        ),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amount: ₹${allTransactions[index][DBHelper.COLUMN_TRANSACTION_AMOUNT]}'),
                            Text('Type: ${allTransactions[index][DBHelper.COLUMN_TRANSACTION_TYPE]}'),
                            Text('Category: ${allTransactions[index][DBHelper.COLUMN_TRANSACTION_CATEGORY]}'),
                            Text('Date: ${allTransactions[index][DBHelper.COLUMN_TRANSACTION_DATE]}'),
                          ]
                      ),

                    trailing: SizedBox(
                      width:60,
                      child:Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children:[
                          InkWell(
                            onTap:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>AddTransactions(
                                    isUpdate: true,
                                    sno: allTransactions[index][DBHelper.COLUMN_TRANSACTION_SNO],
                                    title: allTransactions[index][DBHelper.COLUMN_TRANSACTION_TITLE],
                                    amount: allTransactions[index][DBHelper.COLUMN_TRANSACTION_AMOUNT],
                                    category: allTransactions[index][DBHelper.COLUMN_TRANSACTION_CATEGORY],
                                    type: allTransactions[index][DBHelper.COLUMN_TRANSACTION_TYPE],
                                  ),
                                  )
                              );
                              context.read<TransactionProvider>().getInitialTransactions();
                            },
                            child:Icon(Icons.edit),

                          ),


                          InkWell(
                            onTap:() {
                              int sno=allTransactions[index][DBHelper.COLUMN_TRANSACTION_SNO];
                              context.read<TransactionProvider>().deleteTransaction(sno);
                            },
                            child: Icon(Icons.delete,color:Colors.redAccent),
                          )
                        ],
                      ),
                    ),

                  ),
                ),
              );
            },
          )
              : const Center(
            child: Text("No Transaction yet!"),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(
            builder: (context) => AddTransactions(),
          )
          );
          context.read<TransactionProvider>().getInitialTransactions();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}


