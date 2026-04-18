import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/routes/routes.dart';

class GoogleAuthServices  extends ChangeNotifier {

  GoogleAuthServices._internal();

  static final GoogleAuthServices _instance = GoogleAuthServices._internal();

  factory GoogleAuthServices(){
    return _instance;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get currentUser => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }
  Box get _box => Hive.box(loginBoxKey);

  Future<User?> signInWithGoogle() async {
    setLoading(true);
    try{

      await _googleSignIn.initialize();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(scopeHint: ['email']);

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken:googleAuth.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);


   _user = userCredential.user;
   print(_user?.uid);

   if(_user != null){
     await saveUserToFirestore(_user!);
     await saveUserToLocalStorage(_user!);
     Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.allTaskScreen);
   }else{
       setLoading(false);
       return null;
   }
  setLoading(false);
   return _user;

    }catch(e){
      setLoading(false);
      debugPrint("error login with google ${e.toString()}");
      rethrow;
    }

  }


  Future<void> saveUserToLocalStorage(User user)async{
    await _box.put("isLoggedIn", "google");
    await _box.put("uid", user.uid);
    await _box.put("name", user.displayName ?? "");
    await _box.put("email", user.email ?? "");
    await _box.put("photo", user.photoURL ?? "");
  }

  Future<void> saveUserToFirestore(User user)async{
    final docRef =  _firestore.collection("users").doc(_user?.uid);
    final doc = await docRef.get();

    if(!doc.exists){
      await docRef.set({
        "uid": user.uid,
        "name": user.displayName,
        "email": user.email,
        "photo": user.photoURL,
        "createdAt": FieldValue.serverTimestamp(),
      });
    }

  }

}