import 'package:flutter/material.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/shared/constants.dart';
import 'package:myapp/shared/loading.dart';

class register extends StatefulWidget {

  final Function toggleView;
  const register({required this.toggleView});

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up in Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: (){
                widget.toggleView();
              }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Your Password must be 6 Character long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  setState(() => loading = true );
                  if(_formKey.currentState!.validate()){
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null){
                     setState(() {
                       error = 'Enter correct Email';
                       loading = false;
                     });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
               error,
               style: TextStyle(color: Colors.red[500], fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
