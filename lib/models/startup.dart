
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
class Startup
{
      static Future<bool> isUserLoggedIn() async {
      var user = await _auth.currentUser();
      return user != null;

    }
}