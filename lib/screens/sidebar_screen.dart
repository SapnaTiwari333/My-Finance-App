import 'package:flutter/material.dart';
import 'package:myfinance/screens/login.dart';

import 'package:myfinance/screens/signup_screen.dart';
import 'package:myfinance/services/auth_service.dart';

class SideBarScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children:[
          UserAccountsDrawerHeader(
            accountEmail: Text(""),
            accountName: Text(""),
            decoration: BoxDecoration(
              color:Colors.redAccent.shade100,
              gradient: LinearGradient(colors: [Colors.redAccent,Colors.redAccent.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
              ),
            ),
          ),

          Expanded(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [


                  SizedBox(
                    height:20
                  ),
                  SidebarItem(
                      icon: Icons.logout,
                      title: "Log Out",
                      onTap: () async{
                        await AuthServices().logOut();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>LoginPage()
                            )
                        );
                      }
                  ),

                  SizedBox(
                      height:20
                  ),

                  SidebarItem(icon: Icons.delete,
                      title: "Delete Account",
                      onTap: () async{
                         await AuthServices().deleteAccount();
                         Navigator.of(context).pushReplacement(
                             MaterialPageRoute(builder: (context)=>Signuppage()
                             )
                         );
                      }
                  ),

                  SizedBox(
                      height:20
                  ),



                ],
              ),
            )
          )
        ]

      )
    );
  }

}

class SidebarItem extends StatelessWidget{

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SidebarItem({
    required this.icon,
    required this.title,
    required this.onTap,
});
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 11,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child:ListTile(
        leading: Icon(icon,color: Colors.redAccent.shade100),
        title: Text(
          title,style:TextStyle(
          fontSize:16,
          fontWeight:FontWeight.w600,
          letterSpacing:1.5
        ),
        ),
        onTap: onTap,
      )
    );
  }

}