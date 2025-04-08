import 'package:flutter/material.dart';
import 'package:myfinance/models/category/db_helper_category.dart';
import 'package:myfinance/providers/category_provider.dart';
import 'package:myfinance/screens/add_category_details.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: CategoryPage(),
    debugShowCheckedModeBanner: false,
  ));
}



class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {


  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getInitialCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade100,
        title: const Center(
          child: Text(
            'CATEGORIES',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (ctx, provider, _) {
          List<Map<String, dynamic>>allCategory = provider.getCategory();
          return allCategory.isNotEmpty
              ? ListView.builder(
            itemCount: allCategory.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 11,
                  child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(
                          allCategory[index][DbHelperCategory.COLUMN_CATEGORY_NAME],
                        style: TextStyle(
                        fontSize:18,fontWeight:FontWeight.bold
                      ),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Type:${allCategory[index][DbHelperCategory
                                .COLUMN_CATEGORY_TYPE]}'),
                            Text('Description:${allCategory[index][DbHelperCategory
                                .COLUMN_CATEGORY_DESCRIPTION]}'),

                          ]

                      ),
                      trailing: SizedBox(
                          width: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          AddCategory(
                                            isUpdate: true,
                                            sno: allCategory[index][DbHelperCategory
                                                .COLUMN_CATEGORY_SNO],
                                            title: allCategory[index][DbHelperCategory
                                                .COLUMN_CATEGORY_NAME],
                                            desc: allCategory[index][DbHelperCategory
                                                .COLUMN_CATEGORY_DESCRIPTION],
                                            type: allCategory[index][DbHelperCategory
                                                .COLUMN_CATEGORY_TYPE],
                                          ),
                                      )
                                  );
                                  context.read<CategoryProvider>()
                                      .getInitialCategory();
                                },
                                child: Icon(Icons.edit,),
                              ),

                              InkWell(
                                onTap: () {
                                  int sno = allCategory[index][DbHelperCategory
                                      .COLUMN_CATEGORY_SNO];
                                  context.read<CategoryProvider>().deleteCategory(
                                      sno);
                                },
                                child: Icon(Icons.delete,color: Colors.red),
                              )
                            ],
                          )
                      )
                  ),
                ),
              );
            },


          )
              : const Center(
            child: Text("No Category yet!"),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddCategory(),
          )
          );
          context.read<CategoryProvider>().getInitialCategory();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

