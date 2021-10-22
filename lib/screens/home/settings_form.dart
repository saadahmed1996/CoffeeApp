import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/database.dart';
import 'package:myapp/shared/constants.dart';
import 'package:myapp/shared/loading.dart';
import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = 'User';
  String _currentSugars = '0';
  int _currentStrength = 100;
  bool strFlg = true;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomClassName?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData? userData = snapshot.data;
          // UserData? userData = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update your brew settings',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      initialValue: userData?.name,
                      decoration: textInputDecoration,
                      validator: (val) => val!.isEmpty ? 'Please Enter a Name' : null,
                      onChanged: (val) => setState(() => _currentName = val.toString() ),
                    ),
                    SizedBox(height: 20.0,),
                    //Dropdown
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ?? userData!.sugars,
                      items: sugars.map((sugar){
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val.toString() ),
                    ),
                    //slider
                    Slider(
                      value: (_currentStrength ?? userData!.strength).toDouble(),
                      activeColor: Colors.brown[_currentStrength ?? userData!.strength],
                      inactiveColor: Colors.brown[_currentStrength ?? userData!.strength],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) => setState(() => _currentStrength = val.round()),
                    ),
                    //button
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData!.sugars,
                            _currentName ?? userData!.name,
                            _currentStrength ?? userData!.strength
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              );
        }else{
          return Loading();
        }
      }
    );
  }
}
