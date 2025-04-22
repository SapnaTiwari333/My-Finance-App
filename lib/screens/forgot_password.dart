import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfinance/screens/SnackBar.dart';


class ForgotPassword extends StatelessWidget {


   final TextEditingController emailController=TextEditingController();
   final formKey=GlobalKey<FormState>();

   final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation:11,

            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(20),
            ),
            child: Container(
                height:400,
                width: double.infinity,

                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(20),
                ),
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(

                      mainAxisAlignment:MainAxisAlignment.center,
                      children:[
                        Text("FORGOT PASSWORD",
                            style:TextStyle(
                              fontSize:22,
                              fontWeight:FontWeight.bold,
                              color:Colors.black,
                              letterSpacing:1.5,
                            )
                        ),

                        SizedBox(height:20),

                        Text("Enter your email ID to reset your password",
                            style:TextStyle(
                                fontSize:16,
                                color:Colors.black54,
                                letterSpacing: 0.7
                            )
                        ),

                        SizedBox(height:30),

                        Form(
                          key:formKey,
                          child:TextFormField(
                            controller: emailController,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Email is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText:"Email ID",
                              hintStyle:TextStyle(
                                letterSpacing:1.5,
                              ),
                              focusedBorder:OutlineInputBorder(
                                  borderRadius:BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color:Colors.blueAccent,
                                  )
                              ),

                              enabledBorder:OutlineInputBorder(
                                borderRadius:BorderRadius.circular(12),
                                borderSide:BorderSide(
                                  color:Colors.black,
                                ),
                              ),

                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),

                            ),
                          ),

                        ),

                        SizedBox(height:30),
                        SizedBox(
                            width:double.infinity,
                            child:ElevatedButton(
                                onPressed: () async{
                                  await auth.sendPasswordResetEmail(
                                      email: emailController.text).then((value){
                                        //if success then show this message
                                    showSnackBar(context, "We have send you the reset password link to your email id,please check it");
                                  })
                                      .onError((error,stackTrace){
                                        //if un success then error message
                                    showSnackBar(context, error.toString());

                                  });
                                  //terminate the dialog after send the forgot password link
                                  Navigator.pop(context);
                                  emailController.clear();

                                },

                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(12),
                                    )
                                ),

                                child: Text("SUBMIT",
                                    style:TextStyle(
                                        fontSize:18,
                                        letterSpacing: 1.5,
                                        color:Colors.white
                                    )
                                )
                            )
                        )

                      ]
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }

}