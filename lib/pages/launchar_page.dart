
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth_prefs.dart';
import 'contact_list_page.dart';
import 'login_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName ='/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    getLoginStatus().then((value){
      if(value){
        Navigator.pushReplacementNamed(context, ContactListPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LogInPage.routeName);
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }


}
