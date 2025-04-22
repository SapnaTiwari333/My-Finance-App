import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //for storing data in cloud fireStore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;


//for signup
  Future<String> signUpUser({
    required String name,
    required String email,
    required String password
  }) async {
    String res="Some error Occurred";
    try{
      // register user in firebase auth with email and password
      UserCredential credential =await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );

      //for adding user to our firebase store
      await _firestore.collection("User").doc(credential.user!.uid).set({
        'name':name,
        'email':email,
        'uid':credential.user!.uid,

        //password cannot be stored in the firebase store
      });
      res="Success";

    }
    catch(e){
      print(e.toString());
    }
    return res;

  }

  //for login
  Future<String> loginUser({
    required String email,
    required String password,
    }) async{
    String res="Some Error Occurred";
    try{
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      res="Success";
    }catch(e){
      print(e.toString());
    }
    return res;
  }

  //logout

  Future<void> logOut() async{
    await _auth.signOut();
  }

  //delete the account
  Future<void> deleteAccount() async{

    final user =  _auth.currentUser;
    _firestore.collection("User").doc(user!.uid).delete();
    await _auth.currentUser?.delete();

  }
}