import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  User? _user;
  User? get currentUser => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

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
     Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.allTaskScreen);
   }
  setLoading(false);
   return _user;

    }catch(e){
      setLoading(false);
      debugPrint("error login with google ${e.toString()}");
      rethrow;
    }

  }

}