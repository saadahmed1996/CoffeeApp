import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/authenticate/authenticate.dart';
import 'package:myapp/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

   /* final user = Provider.of<CustomClassName>(context);
    print(user);
*/
    final user = Provider.of<CustomClassName?>(context);

    //return either home or authenticate widget
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
