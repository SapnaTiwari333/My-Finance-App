import "package:flutter/material.dart";
import "package:myfinance/screens/category_screen.dart";
import "package:myfinance/screens/homepage.dart";
import "package:myfinance/screens/sidebar_screen.dart";
import "package:myfinance/screens/transactions_page.dart";

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});
  @override
  State<StatefulWidget> createState() =>DashboardState();
  }


class DashboardState extends State<DashboardScreen>{

  int selectedIndex=0;

  //List of pages to display for Each BottomNavigationBarItem
  final List<Widget>pages=[
    HomePage(),
    TransactionPage(),
    CategoryPage(),

  ];

  void onItemTapped(int index){
    setState(() {
      selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SideBarScreen(),
      ),
      appBar: AppBar(
        //title: const Center(child: Text("My Finance")),
        backgroundColor: Colors.redAccent.shade100,

        leading: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor:Colors.transparent,
                onTap: (){
                  Scaffold.of(context).openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),

                    child: Icon(Icons.menu,size: 30,),
                  ),
                ),
              );
          }
        ),
        ),

      body:IndexedStack(
        index:selectedIndex,
        children:pages,
      ),
      bottomNavigationBar: Card(
        child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon:Icon(Icons.home,size:30),
                label:"HOME",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                label: "Transactions"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                label: "Category",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.notifications),
                label: "Notifications",
              ),
             /* BottomNavigationBarItem(icon: Icon(Icons.settings),
                label: "Settings"
              ),*/
            ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.redAccent.shade100,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: TextStyle(
            fontSize:15,
            fontWeight:FontWeight.bold,
        
          ),
          unselectedLabelStyle: TextStyle(
            fontSize:12,
              fontWeight:FontWeight.bold
          ),
          onTap: onItemTapped,
        ),
      ),
    );

  }

}
