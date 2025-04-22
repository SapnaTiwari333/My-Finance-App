
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfinance/firebase_options.dart';
import 'package:myfinance/screens/login.dart';
import 'package:myfinance/services/auth_service.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MaterialApp(
    home: Signuppage(),
    debugShowCheckedModeBanner: false,
  ));
}

class Signuppage extends StatefulWidget{

  @override
  State<StatefulWidget> createState()=>SignupState();

}

class SignupState extends State<Signuppage>{



  final TextEditingController nameText=TextEditingController();
  final TextEditingController emailText=TextEditingController();
  final TextEditingController passText=TextEditingController();
  final TextEditingController confirmPassword=TextEditingController();




  //for authentication
  void signupUser() async{
    String res=await AuthServices().signUpUser(
        name: nameText.text,
        email: emailText.text,
        password: passText.text
    );
    
    if(res=="Success"){
      setState(() {
        
      });
      Navigator.of(context).
      pushReplacement(
          MaterialPageRoute(
              builder: (context)=>LoginPage()
          )
      );
    }
  }


  //bool variable to hide and show password
  bool isVisible=false;

  //create global variable
  var formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),

      body:Center(
        child:SingleChildScrollView(

          child:Form(
            key:formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:[
                  /*Container(
                      height:250,
                      child: Image.asset("assets/images/image3.png")),
                  SizedBox(
                    height:20,
                  ),*/

                  //for user name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //margin:const EdgeInsets.only(top: 20.0),

                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(21),


                      ),
                      child: TextFormField(
                        validator:(value){
                          if(value!.isEmpty){
                            return "user name required";
                          }
                          return null;
                        },
                        controller:nameText,
                        decoration:InputDecoration(
                          hintText:"Enter name",
                          hintStyle: const TextStyle(
                              color: Colors.black54,
                              letterSpacing: 1.5
                          ),
                          suffixStyle: const TextStyle(fontWeight: FontWeight.bold),
                          focusedBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(40),
                            borderSide:const BorderSide(
                              color:Colors.deepOrange,
                            ),

                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(40),
                            borderSide:const BorderSide(
                              color:Colors.blueAccent,
                            ),
                          ),
                          prefixIcon:const Icon(Icons.person),
                          //fillColor: Colors.purple.shade100,
                          //filled: true,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height:20,
                  ),

                  //user email
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //margin:const EdgeInsets.only(top: 20.0),

                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(21),


                      ),
                      child: TextFormField(
                        validator:(value){
                          if(value!.isEmpty){
                            return "email is required";
                          }
                          return null;
                        },
                        controller:emailText,
                        decoration:InputDecoration(
                          hintText:"Enter email",
                          hintStyle: const TextStyle(
                              color: Colors.black54,
                              letterSpacing: 1.5
                          ),
                          suffixStyle: const TextStyle(fontWeight: FontWeight.bold),
                          focusedBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(40),
                            borderSide:const BorderSide(
                              color:Colors.deepOrange,
                            ),

                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(40),
                            borderSide:const BorderSide(
                              color:Colors.blueAccent,
                            ),
                          ),
                          prefixIcon:const Icon(Icons.email),
                          //fillColor: Colors.purple.shade100,
                          //filled: true,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height:20,
                  ),

                  //input for password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //margin:const EdgeInsets.only(top: 20.0),

                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(40),

                      ),
                      child:TextFormField(
                        validator:(value){
                          if(value!.isEmpty){
                            return "password is required";
                          }
                          return null;
                        },
                        obscureText:!isVisible,
                        obscuringCharacter:'*',
                        controller:passText,
                        decoration:InputDecoration(
                          hintText:"Enter password",
                          hintStyle: const TextStyle(
                              color: Colors.black54,
                              letterSpacing: 1.5
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(40),
                            borderSide:const BorderSide(
                              color:Colors.deepOrange,
                            ),
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(40),
                            borderSide:const BorderSide(
                              color:Colors.blueAccent,
                            ),
                          ),
                          prefixIcon:const Icon(Icons.lock),
                          //fillColor: Colors.purple.shade100,
                          // filled: true,
                          suffixIcon:IconButton(
                            onPressed:(){
                              setState((){
                                isVisible=!isVisible;
                              });

                            },
                            icon:Icon(isVisible?Icons.visibility:Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height:20,
                  ),

                  //confirm password field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                     // margin:const EdgeInsets.only(top: 20.0),

                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(40),

                      ),
                      child:TextFormField(
                        validator:(value){
                          if(value!.isEmpty){
                            return "password is required";
                          }
                          else if(passText.text!=confirmPassword.text){
                            return "password don't match";
                          }
                          return null;
                        },
                        controller: confirmPassword,
                        obscureText:!isVisible,
                        obscuringCharacter:"*",
                        decoration:InputDecoration(
                            hintText:"confirm password",
                            hintStyle: const TextStyle(
                                color: Colors.black54,
                                letterSpacing: 1.5
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(40),
                              borderSide:const BorderSide(
                                color:Colors.deepOrange,
                              ),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(40),
                              borderSide:const BorderSide(
                                color:Colors.blueAccent,
                              ),
                            ),
                            prefixIcon:const Icon(Icons.lock),
                            //fillColor: Colors.purple.shade100,
                            //filled: true,
                            suffixIcon:IconButton(
                              onPressed:(){
                                setState(() {
                                  isVisible=!isVisible;
                                });

                              },
                              icon:Icon(isVisible?Icons.visibility:Icons.visibility_off),
                            )
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height:20,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width:400,
                      //color:Colors.blueAccent.shade200,
                      child:TextButton(
                        style:TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(40),
                          ),
                          backgroundColor: Colors.blueAccent.shade200
                        ),
                        onPressed:(){
                          signupUser();
                        },
                        child:const Text("SIGN UP",
                            style:TextStyle(
                                fontSize:20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5)
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height:30,
                  ),

                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:[
                      const Text("Already have Account?",
                          style:TextStyle(
                              fontSize:18,
                              color: Colors.black45,
                              fontWeight:FontWeight.bold,
                              letterSpacing: 1.2)
                      ),

                      const SizedBox(
                        width:10,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          Navigator.of(context).
                          pushReplacement(
                              MaterialPageRoute(
                                  builder: (context)=>LoginPage()
                              )
                          );

                        },
                        child: const Text("Login",
                          style:TextStyle(
                              fontSize:18,
                              color: Colors.blue,
                              fontWeight:FontWeight.bold,
                              letterSpacing: 1.2),

                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),


    );
  }

}