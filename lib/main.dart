import 'package:flutter/material.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/user.dart';

void main() => runApp(myapp());

class myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

      return StreamProvider<CustomClassName?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          home: Wrapper(),
    ),
      );
  }
}