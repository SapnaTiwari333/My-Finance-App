import "package:flutter/material.dart";
import "package:myfinance/providers/category_provider.dart";
import "package:provider/provider.dart";

void main() {
  runApp(MaterialApp(
    home: AddCategory(),
    debugShowCheckedModeBanner: false,
  ));
}

class AddCategory extends StatefulWidget{
  final bool isUpdate;
  final int sno;
  final String? title;
  final String? desc;
  final String? type;

  const AddCategory({
    Key?key,
    this.isUpdate=false,
    this.sno=0,
    this.title=" ",
    this.desc=" ",
    this.type=" "
}):super(key:key);
  @override
  State<StatefulWidget> createState() =>AddCategoryState();

}

class AddCategoryState extends State<AddCategory>{


  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController typeController=TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.isUpdate){
      titleController.text=widget.title??" ";
      descController.text=widget.desc??" ";
      typeController.text=widget.type??" ";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.redAccent.shade100,
        title:Center(
            child: Text(widget.isUpdate? "Update Category":"Add Category",
            style:TextStyle(fontSize:25,
                fontWeight:FontWeight.bold,
                letterSpacing:0.8),
            ),
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:SingleChildScrollView(
            child: Column(
              children:[
            
                SizedBox(
                  height:50,
                ),
            
                //TextForm for title
                TextFormField(
                  controller:titleController,
                  decoration:InputDecoration(
                    hintText:"Enter title here",
                    hintStyle:TextStyle(letterSpacing:0.8),
                    focusedBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(11),
                      borderSide:BorderSide(
                        color:Colors.blueAccent,
                      )
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
            
                //TextForm for description
                TextFormField(
                    controller:descController,
                    decoration:InputDecoration(
                        hintText:"Enter desc here",
                        hintStyle:TextStyle(letterSpacing:0.8),
                        focusedBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(11),
                            borderSide:BorderSide(
                              color:Colors.blueAccent,
                            )
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
            
                //TextForm for type
                TextFormField(
                    controller:typeController,
                    decoration:InputDecoration(
                        hintText:"Enter type here",
                        hintStyle:TextStyle(letterSpacing:0.8),
                        focusedBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(11),
                            borderSide:BorderSide(
                              color:Colors.blueAccent,
                            )
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
            
                Row(
                  children:[
                    Expanded(
                      child:OutlinedButton(
                        style:OutlinedButton.styleFrom(
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(11),
                          )
                        ),
                        onPressed:(){
                          if(titleController.text.isNotEmpty && descController.text.isNotEmpty && typeController.text.isNotEmpty ){
                            if(widget.isUpdate){
                              context.read<CategoryProvider>().updateCategory(
                                  widget.sno,
                                  titleController.text,
                                  typeController.text,
                                  descController.text
                              );
                            }else{
                              context.read<CategoryProvider>().addCategory(
                                  titleController.text,
                                  typeController.text,
                                  descController.text
                              );
                            }
                            Navigator.pop(context);
                          }
            
                        },
                        child:Text(widget.isUpdate? "Update Category": "Add category",
                            style:TextStyle(letterSpacing:0.8),
                        )
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
                        child:Text("Cancel",style:TextStyle(letterSpacing:0.8),
                        ),
                      )
                    )
                  ]
                )
              ]
              ),
          )
          ),
      )

    );
  }

}