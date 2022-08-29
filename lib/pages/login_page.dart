
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth_prefs.dart';
import 'contact_list_page.dart';

class LogInPage extends StatefulWidget {
  static const String routeName ='/login';
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure =true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email,),
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: passwordController,
                obscureText: isObscure,
                decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock,),
                  suffixIcon: IconButton(
                    icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: (){
                      setState((){
                        isObscure = !isObscure;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                  onPressed: (){
                    setLoginStatus(true).then((value) => Navigator.pushReplacementNamed(context, ContactListPage.routeName));
                  },
                  child: const Text('LOGIN')),
            ],
          ),
        ),
      ),
    );
  }
}
