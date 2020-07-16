import 'package:flutter/material.dart';
import 'package:kirana/pages/items.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/widgets/RedirectPage.dart';
import 'package:kirana/pages/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kirana/models/user.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  User user;

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
                  DescriptionText('Sign Up'),
                  TextFieldWidgetWithValidation('Full Name', _nameController),
                  TextFieldWidgetWithValidation('Email', _emailController),
                  TextFieldWidgetWithValidation(
                      'password', _passwordController),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 50, left: 200),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
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
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _register();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Sign Up",
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
                  )
                ],
              ),
              GoogleSignInSection("Signup"),
              RedirectPage(SignInPage(), 'Sign in', 'Have we met before'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    user = Provider.of<User>(context, listen: false);
    var response = await user.register(
        userEmail: _emailController.text,
        userPassword: _passwordController.text,
        userName: _nameController.text);
    if (response is bool) {
      _showMyDialog(_emailController.text);
    } else {
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$response")));
    }
  }

  Future<void> _showMyDialog(email) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An Email sent to your email '),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${email}",
                  style: TextStyle(
                      color: Colors.green[800], fontWeight: FontWeight.bold),
                ),
                Text("Please verify and SignIn")
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
                      (dynamic) => dynamic == ModalRoute.withName("/signup"));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUp(),
    );
  }
}
