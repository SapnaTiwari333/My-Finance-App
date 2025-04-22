import 'package:flutter/material.dart';
import 'package:myfinance/screens/dashboard_screen.dart';
import 'package:myfinance/screens/forgot_password.dart';
import 'package:myfinance/screens/signup_screen.dart';
import 'package:myfinance/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myfinance/firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final TextEditingController emailText = TextEditingController();
  final TextEditingController passText = TextEditingController();
  bool isVisible = false;

  final formKey = GlobalKey<FormState>();


 //for authentication
  void signInUser() async{
    String res=await AuthServices().loginUser(
        email: emailText.text,
        password: passText.text
    );

    if(res=="Success"){
      setState(() {

      });
      Navigator.of(context).
      pushReplacement(
          MaterialPageRoute(
              builder: (context)=>DashboardScreen()
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blueAccent,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        //margin: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          controller: emailText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter email",
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              letterSpacing: 1.5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: Colors.blueAccent,
                              ),
                            ),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                       // margin: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          controller: passText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              letterSpacing: 1.5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: Colors.blueAccent,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                  isVisible ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                     Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: const Text(
                            "Forget Password",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              letterSpacing: 1.2,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width:400,
                        //color: Colors.blueAccent.shade200,
                        child: TextButton(
                          style:TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(40),
                              ),
                              backgroundColor: Colors.blueAccent.shade200
                          ),
                          onPressed: () {
                           signInUser();
                          },
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an Account?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).
                            pushReplacement(
                                MaterialPageRoute(
                                    builder: (context)=>Signuppage()
                                )
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
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
      ),
    );
  }
}
