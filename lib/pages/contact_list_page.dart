
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_prefs.dart';
import '../provider/contact_provider.dart';
import 'contact_details_page.dart';
import 'login_page.dart';
import 'new_contact_page.dart';

class ContactListPage extends StatefulWidget {

  static const String routeName='/contact';


  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {

  int seletedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: (){
                  setLoginStatus(false).then((value) => Navigator.pushReplacementNamed(context, LogInPage.routeName)
                  );
                },
                child: const Text('Logout'),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Consumer<ContactProvider>(
          builder: (context, provider, _) => BottomNavigationBar(
            currentIndex: seletedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            onTap: (value){
              setState((){
                seletedIndex = value;
              });
              if(seletedIndex == 0){
                provider.getAllContacts();
              } else if(seletedIndex == 1){
                provider.getAllFavoriteContacts();
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'all',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
            ],
          ),
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, _) => ListView.builder(

          itemCount: provider.contactList.length,
            itemBuilder: (context, index){
              final contact = provider.contactList[index];
              return Dismissible(
                key: ValueKey(contact.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: _showConfirmationDialog,
                onDismissed: (direction){
                  provider.deleteContact(contact.id!);
                },
                background: Container(
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.grey,
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete,size: 40,),
                ),
                child: ListTile(
                  onTap: () => Navigator
                      .pushNamed(context, ContactDetails.routeName, arguments: contact.id),
                  title: Text(contact.name),
                  subtitle: Text(contact.number),
                  trailing: IconButton(
                      onPressed: (){
                        provider.updateFavorite(contact.id!, contact.favourite, index);
                      },
                      icon: Icon(contact.favourite ? Icons.favorite : Icons.favorite_border, color: Colors.black,)
                  ),
                ),
              );
            },
            ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
        child: Icon(Icons.add),
        tooltip: 'Add new Contact',
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog(context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Contact'),
          content: const Text('Are you sure to delete this contact'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('NO')
            ),
            TextButton(onPressed: () => Navigator.pop(context, true),
                child: const Text('YES')
            ),
          ],
        ));
  }
}
