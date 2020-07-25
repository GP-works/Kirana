import 'package:flutter/material.dart';
import 'package:kirana/pages/items.dart';
import 'package:kirana/pages/navigation.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/RedirectPage.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:email_validator/email_validator.dart';
import 'package:kirana/models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User _user;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  DescriptionText('Sign In'),
                  TextFieldWidgetWithValidation('Email', _emailController),
                  TextFieldWidgetWithValidation(
                      'password', _passwordController),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 50, left: 200),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: Offset(5, 5))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: FlatButton(
                        onPressed: () {
                          _signInWithEmailAndPassword();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.lightBlueAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GoogleSignInSection("Login"),
                  RedirectPage(SignUpPage(), 'Sign Up', 'New User?'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Text("Forgot Password?"),
                        FlatButton(
                          child: Text(
                            "Reset",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            if (EmailValidator.validate(
                                _emailController.text)) {
                              resetPassword(_emailController.text);
                              _showMyDialog(_emailController.text);
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Please enter valid email ")));
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )));
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  void _signInWithEmailAndPassword() async {
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user != null) {
        if (user.isEmailVerified) {
          setState(() {
            _user = User();
            _user.setData();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Navigation()));
          });
        } else {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Please verify email ")));
        }
      } else {}
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> _showMyDialog(email) async {
    return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An Email was sent to your email'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${email}",
                  style: TextStyle(
                      color: Colors.green[800], fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("With further steps please check your email")
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 3, 0, 0, 0),
              child: FlatButton(
                child: Text('Ok', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/signin',
                      (dynamic) => dynamic == ModalRoute.withName("/signin"));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignIn(),
    );
  }
}
