import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kirana/pages/home.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final CollectionReference _usersCollectionReference =
Firestore.instance.collection("users");
final FirebaseAuth _auth = FirebaseAuth.instance;

class User {
  String uid;
  String name;
  String email;
  String role;

  User({this.uid, this.name, this.email, this.role});

  User.fromData(Map<String, dynamic> data)
      : uid = data['id'],
        name = data['fullName'],
        email = data['email'],
        role = data['userRole'];

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'fullName': name,
      'email': email,
      'userRole': role,
    };
  }
  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
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
    DocumentSnapshot ds = await _usersCollectionReference.document(uid).get();
    if (!ds.exists) {
      try {
        await _usersCollectionReference.document(uid).setData(toJson());
        return true;
      } catch (e) {
        return e.message;
      }
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
  User _user=User();

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
            child:  Text('${widget.from} with Google'),
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
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null && user.isEmailVerified) {
        _user.uid = user.uid;
        _user.email = user.email;
        _user.name = user.displayName;
        _user.role = "user";
        _user.createUser();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeApp()));
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
