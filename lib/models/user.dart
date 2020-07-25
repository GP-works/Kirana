import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kirana/pages/navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

final FirebaseAuth _auth = FirebaseAuth.instance;

class User extends ChangeNotifier {
  String uid;
  String name;
  String email;
  String role;
  User();
  User.fromData(Map<String, dynamic> data)
      : uid = data['id'],
        name = data['fullName'],
        email = data['email'],
        role = data['userRole'];

  void setData() async {
    FirebaseUser user = await _auth.currentUser();
    final CollectionReference _usersCollectionReference =
        Firestore.instance.collection("users");
    var data = await _usersCollectionReference.document(user.uid).get();
    uid = data['id'];
    name = data['fullName'];
    email = data['email'];
    role = data['userRole'];
    notifyListeners();
    writetoSf();
    print("called firestore");
  }

  void writetoSf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", uid);
    await prefs.setString("name", name);
    await prefs.setString("email", email);
    await prefs.setString("role", role);
    notifyListeners();
  }

  void checkValidAndUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');
    if (id == uid) {
      name = prefs.getString('name');
      email = prefs.getString('email');
      role = prefs.getString('role');
      print("read from device");
      notifyListeners();
    } else {
      FirebaseUser user = await _auth.currentUser();
      setData();
      notifyListeners();
      writetoSf();
      notifyListeners();
    }
  }

  void getfromSf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkValidAndUpdate();
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'fullName': name,
      'email': email,
      'userRole': role,
    };
  }

  Future register(
      {@required userEmail, @required userPassword, @required userName}) async {
    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      ))
          .user;
      if (user != null) {
        try {
          await user.sendEmailVerification();
        } catch (e) {
          return e.message;
        }
        email = user.email;
        uid = user.uid;
        name = userName;
        role = "user";
        notifyListeners();
        try {
          return await createUser();
        } catch (e) {
          return e.message;
        }
      } else {
        return "error signining up";
      }
    } catch (e) {
      return e.message;
    }
  }

  Future createUser() async {
    final CollectionReference _usersCollectionReference =
        Firestore.instance.collection("users");
    DocumentSnapshot ds = await _usersCollectionReference.document(uid).get();
    if (!ds.exists) {
      try {
        await _usersCollectionReference.document(uid).setData(toJson());
        notifyListeners();
        return true;
      } catch (e) {
        return e.message;
      }
    } else {
      notifyListeners();
    }
  }

  void signout(context) async {
    uid = name = email = role = null;
    notifyListeners();
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, "/signin");
  }

  bool isLogged() {
    if (uid != null)
      return true;
    else {
      get();
      if (uid != null)
        return true;
      else
        return false;
    }
  }

  void get() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      uid = user.uid;
      getfromSf();
      notifyListeners();
    }
  }
}

class GoogleSignInSection extends StatefulWidget {
  final from;

  GoogleSignInSection(this.from);

  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<GoogleSignInSection> {
  User _user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: const Text('OR'),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
              _signInWithGoogle();
            },
            child: Text('${widget.from} with Google'),
          ),
        ),
      ],
    );
  }

  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authresult = (await _auth.signInWithCredential(credential));
    final FirebaseUser user = authresult.user;
    assert(user.email != null);
    assert(user.displayName != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null && user.isEmailVerified) {
        _user = Provider.of<User>(context, listen: false);
        if (authresult.additionalUserInfo.isNewUser) {
          _user.uid = user.uid;
          _user.email = user.email;
          _user.name = user.displayName;
          _user.role = "user";
          _user.createUser();
        } else {
          _user.setData();
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      } else {
        if (user != null) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Please verify email ")));
        } else {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Unable to login ")));
        }
      }
    });
  }
}

void ChangeStatus() async {
  FirebaseUser user = await _auth.currentUser();
  Firestore.instance
      .collection('users')
      .document(user.uid)
      .updateData({"userRole": 'owner'});
  User user1 = User();
  user1.setData();
  user1.writetoSf();
}
