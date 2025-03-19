import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance/models/category/db_helper_category.dart';

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
  List<Map<String, dynamic>> allCategories = [];
  final dbRef = DBHelperCategory.getInstance;

  // Form controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController createdAtController = TextEditingController();
  TextEditingController updatedAtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  // ✅ Fetch All Categories
  void getCategories() async {
    allCategories = await dbRef.getAllCategories();
    setState(() {});
  }

  // 📅 Date Picker
  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
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
            'CATEGORIES',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: allCategories.isNotEmpty
          ? ListView.builder(
        itemCount: allCategories.length,
        itemBuilder: (_, index) {
          final category = allCategories[index];

          return ListTile(
            leading: Text('${index + 1}'),
            title: Text(category[DBHelperCategory.COLUMN_CATEGORY_NAME]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Type: ${category[DBHelperCategory.COLUMN_CATEGORY_TYPE]}'),
                Text('Description: ${category[DBHelperCategory.COLUMN_CATEGORY_DESCRIPTION]}'),
                Text('Created At: ${category[DBHelperCategory.COLUMN_CATEGORY_CREATED]}'),
                Text('Updated At: ${category[DBHelperCategory.COLUMN_CATEGORY_UPDATED]}'),
              ],
            ),
            trailing: SizedBox(
              width: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Edit button
                  InkWell(
                    onTap: () {
                      nameController.text = category[DBHelperCategory.COLUMN_CATEGORY_NAME];
                      typeController.text = category[DBHelperCategory.COLUMN_CATEGORY_TYPE];
                      descriptionController.text = category[DBHelperCategory.COLUMN_CATEGORY_DESCRIPTION];
                      createdAtController.text = category[DBHelperCategory.COLUMN_CATEGORY_CREATED];
                      updatedAtController.text = category[DBHelperCategory.COLUMN_CATEGORY_UPDATED];

                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => getBottomSheetWidget(
                          isUpdate: true,
                          sno: category[DBHelperCategory.COLUMN_CATEGORY_SNO],
                        ),
                      );
                    },
                    child: const Icon(Icons.edit, color: Colors.green),
                  ),

                  // Delete button
                  InkWell(
                    onTap: () async {
                      bool check = await dbRef.deleteCategory(
                        sno: category[DBHelperCategory.COLUMN_CATEGORY_SNO],
                      );

                      if (check) {
                        getCategories();
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
          : const Center(child: Text("No Categories Yet!!")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nameController.clear();
          typeController.clear();
          descriptionController.clear();
          createdAtController.clear();
          updatedAtController.clear();

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

  // 🔥 Bottom Sheet for Adding/Updating Categories
  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isUpdate ? "Update Category" : "Add Category",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Name Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter name",
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

            // Type Field
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                hintText: "Enter type",
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

            // Description Field
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Enter description",
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

            // Created At Field
            TextField(
              controller: createdAtController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Created At",
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
              ),
              onTap: () => selectDate(context, createdAtController),
            ),
            const SizedBox(height: 15),

            // Updated At Field
            TextField(
              controller: updatedAtController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Updated At",
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
              ),
              onTap: () => selectDate(context, updatedAtController),
            ),
            const SizedBox(height: 20),

            // Save and Cancel Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      bool check = isUpdate
                          ? await dbRef.updateCategory(
                        sno: sno,
                        name: nameController.text,
                        categoryType: typeController.text,
                        description: descriptionController.text,
                        createdAt: createdAtController.text,
                        updatedAt: updatedAtController.text,
                      )
                          : await dbRef.addCategory(
                        name: nameController.text,
                        categoryType: typeController.text,
                        description: descriptionController.text,
                        createdAt: createdAtController.text,
                        updatedAt: updatedAtController.text,
                      );

                      if (check) {
                        getCategories();
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
