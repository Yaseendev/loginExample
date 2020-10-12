
//import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../configuration//config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =TextEditingController();

  final TextEditingController _passwordController =TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _singIn() async{
    String email =_emailController.text.trim();
    String pass =_passwordController.text;
    if(email.isNotEmpty && pass.isNotEmpty)
      _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) =>  showDialog(context: context,
          builder: (ctx){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              title: Text('Logged In'),
              content: Text(user.user.email),
              actions: [
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            );
          })).catchError((e) {
        showDialog(context: context,
            builder: (ctx){
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                title: Text('Error'),
                content: Text('User not found $e'),
                actions: [
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      _emailController.text= '';
                      _passwordController.text ='';
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            });
      });
    else {
      showDialog(context: context,
      builder: (ctx){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          title: Text('Error'),
          content: Text('Please provide email and password...'),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                  _emailController.text= '';
                  _passwordController.text ='';
                Navigator.of(ctx).pop();
                },
            ),
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x5500F58D),
                    blurRadius: 30,
                    offset: Offset(10, 10),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Image(
                image: AssetImage('assets/logo_round.png'),
                width: 200,
                height: 200,
              ),
            ),
            Container(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 40),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'email@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter a password',
                ),
                obscureText: true,
              ),
            ),
            InkWell(
              onTap: () => _singIn(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            FlatButton.icon(
              icon: Icon(Icons.email),
              label: Text('Signup with Email'),
              onPressed: (){},
            ),
            Wrap(
              children: [
                FlatButton.icon(
                  icon: Icon(Icons.category),
                  label: Text('Signup with Google'),
                  onPressed: (){},
                ),
                FlatButton.icon(
                  icon: Icon(Icons.phone_android),
                  label: Text('Signup with phone'),
                  onPressed: (){},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
