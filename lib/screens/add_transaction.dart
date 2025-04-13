
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:myfinance/providers/home_page_provider.dart';

import 'package:myfinance/providers/transaction_provider.dart';
import 'package:provider/provider.dart';



class AddTransactions extends StatefulWidget{
  final bool isUpdate;
  final int sno;
  final String? title;
  final dynamic amount;
  final String? category;
  final  String? type;
  final String? date;

  const AddTransactions({
    Key? key,
     this.isUpdate=false,
    this.sno=0,
    this.title=" ",
    this.amount=" ",
     this.category=" ",
    this.type=" ",
     this.date=" ",
  }):super(key:key);



  @override
  State<AddTransactions> createState() => AddTransactionsState();
}

class AddTransactionsState extends State<AddTransactions> {


  TextEditingController titleController=TextEditingController();
  TextEditingController amountController=TextEditingController();
  TextEditingController categoryController=TextEditingController();
  TextEditingController dateController=TextEditingController();

  String transactionType="Income"; //default type

  //DBHelper?dbRef=DBHelper.getInstance;

  @override
  void initState() {
    super.initState();

    if(widget.isUpdate){
      titleController.text=widget.title?? " ";
      amountController.text=widget.amount?.toString()?? " ";
      categoryController.text=widget.category?? " ";
      transactionType=widget.type?? "Income ";
      dateController.text=widget.date?? " ";
    }
  }



  @override
  Widget build(BuildContext context) {
    //final transactionProvider=Provider.of<TransactionProvider>(context);


    return Scaffold(
      appBar:AppBar(
          backgroundColor: Colors.redAccent.shade100,
        title:Center(
            child: Text(widget.isUpdate? "Update Transaction":"Add Transactions",
                style:TextStyle(
                    fontSize:20,
                    fontWeight:FontWeight.bold,
                    letterSpacing: 0.5)))
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height:30,
                ),

                // TextFormField for title
                TextFormField(
                  controller:titleController,
                  decoration:InputDecoration(
                    hintText:"Enter title here",
                    hintStyle:TextStyle(
                      letterSpacing:0.8
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(11),
                      borderSide:BorderSide(
                       color:Colors.blueAccent,
                      ),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(11),
                      borderSide:BorderSide(
                        color:Colors.black87,
                      )
                    )
                  )
                ),

                SizedBox(
                  height:30,
                ),

                //TextFormField for amount
                TextFormField(
                    controller:amountController,
                    decoration:InputDecoration(
                        hintText:"Enter amount here",
                        hintStyle:TextStyle(
                            letterSpacing:0.8
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(11),
                          borderSide:BorderSide(
                            color:Colors.blueAccent,
                          ),
                        ),
                        enabledBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(11),
                            borderSide:BorderSide(
                              color:Colors.black87,
                            )
                        )
                    )
                ),

                SizedBox(
                  height:30,
                ),

                //TextFormField for transaction Category
                TextFormField(
                    controller:categoryController,
                    decoration:InputDecoration(
                        hintText:"Enter category here",
                        hintStyle:TextStyle(
                            letterSpacing:0.8
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(11),
                          borderSide:BorderSide(
                            color:Colors.blueAccent,
                          ),
                        ),
                        enabledBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(11),
                            borderSide:BorderSide(
                              color:Colors.black87,
                            )
                        )
                    )
                ),

                SizedBox(
                  height:30,
                ),

                // Dropdown for transaction type
                DropdownButtonFormField<String>(
                      value: transactionType,
                      items: ['Income', 'Expense'].map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => transactionType = value!),
                      decoration: const InputDecoration(
                        hintText: "Transaction Type",
                        hintStyle: TextStyle(
                          letterSpacing: 0.8,
                        ),
                        //labelText: "Transaction Type",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11)),  // Rounded border
                          borderSide: BorderSide(
                              color: Colors.blue),  // Blue border on focus
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11)),  // Rounded border
                          borderSide: BorderSide(color: Colors.black87),  // Grey border by default
                        ),
                      ),
                    ),



                SizedBox(
                  height:30,
                ),

                //TextFormField for date
                TextFormField(
                    controller:dateController,
                    readOnly: true,
                    decoration:InputDecoration(
                        hintText:"Enter date",
                        suffixIcon:Icon(Icons.calendar_today),
                        hintStyle:TextStyle(
                            letterSpacing:0.8
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(11),
                          borderSide:BorderSide(
                            color:Colors.blueAccent,
                          ),
                        ),
                        enabledBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(11),
                            borderSide:BorderSide(
                              color:Colors.black87,
                            )
                        )
                    ),
                  onTap: () async{
                    DateTime? picked=await showDatePicker(
                      context: context,
                      initialDate:DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if(picked!=null){
                      setState(() {
                        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                      });
                    }
                  },
                ),

                SizedBox(
                  height:30
                ),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style:OutlinedButton.styleFrom(
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(11),
                          ),
                        ),
                        onPressed: (){
                          if(titleController.text.isNotEmpty && amountController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty && dateController.text.isNotEmpty &&
                              transactionType.isNotEmpty){
                            if(widget.isUpdate){
                              context.read<TransactionProvider>().updateTransactions(
                                  titleController.text,
                                  amountController.text,
                                  transactionType,
                                  categoryController.text,
                                  dateController.text,
                                  widget.sno);
                            }else{
                              context.read<TransactionProvider>().addTransactions(
                                  titleController.text,
                                  amountController.text,
                                  transactionType,
                                  categoryController.text,
                                  dateController.text);
                            }
                            context.read<HomePageProvider>().updateTransactionData();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(widget.isUpdate? "Update Transaction":"Add Transaction",
                            style:TextStyle(letterSpacing:0.8)),
                      ),
                    ),

                    SizedBox(
                      width:10,
                    ),

                    Expanded(
                      child:OutlinedButton(
                        style:OutlinedButton.styleFrom(
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(11),

                          )
                        ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Cancel",style:TextStyle(letterSpacing:0.8))
                      ),
                    )

                  ],
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}

