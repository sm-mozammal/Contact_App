import 'package:contact_managment/pages/contact_details_page.dart';
import 'package:contact_managment/pages/contact_list_page.dart';
import 'package:contact_managment/pages/launchar_page.dart';
import 'package:contact_managment/pages/login_page.dart';
import 'package:contact_managment/pages/new_contact_page.dart';
import 'package:contact_managment/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactProvider()..getAllContacts()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName:(context)=>LauncherPage(),
        LogInPage.routeName:(context)=>LogInPage(),
        NewContactPage.routeName:(context)=>NewContactPage(),
        ContactListPage.routeName:(context)=>ContactListPage(),
        ContactDetails.routeName:(context)=>ContactDetails(),
      },
    );
  }
}