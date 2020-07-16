import 'package:flutter/material.dart';
import 'package:kirana/pages/items.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/RedirectPage.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:email_validator/email_validator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  final _formKey = GlobalKey<FormState>();

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
                  _GoogleSignInSection(),
                  RedirectPage(SignUpPage(), 'Sign Up', 'New User?'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Text("Forgot Password?"),
                        FlatButton(
                          child: Text("Reset",style: TextStyle(fontSize: 20),),
                          onPressed:(){
                            if(EmailValidator.validate(_emailController.text)) {
                              resetPassword(_emailController.text);
                              _showMyDialog(_emailController.text);
                            }
                            else
                              {
                                Scaffold.of(context)
                                    .showSnackBar(SnackBar(content: Text("Please enter valid email ")));
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
            _success = true;
            _userEmail = user.email;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ItemsPage()));
          });
        } else {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Please verify email ")));
        }
      } else {
        _success = false;
      }
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
                SizedBox(height: 10,),
                Text("${email}",style: TextStyle(color: Colors.green[800],fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("With further steps please check your email")
              ],
            ),
          ),
          actions: <Widget>[

            Padding(
              padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/3,0,0,0),
              child: FlatButton(
                child: Text('Ok',style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context,'/signin',(dynamic)=>dynamic==ModalRoute.withName("/signin"));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GoogleSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<_GoogleSignInSection> {
  bool _success;
  String _userID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: const Text('OR'),
          padding: const EdgeInsets.fromLTRB(16,16,16,10),
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
            child: const Text('Login with Google'),
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
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null && user.isEmailVerified) {
        _success = true;
        _userID = user.uid;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ItemsPage()));
      } else {
        if (user != null) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Please verify email ")));
        }
        else
          {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Unable to login ")));
          }
      }
    });
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
