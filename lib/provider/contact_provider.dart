


import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList = [];

  getAllContacts() async{
    contactList = await DBHelper.getAllContacts();
    notifyListeners();
  }

  getAllFavoriteContacts() async{
    contactList = await DBHelper.getAllFavoriteContacts();
    notifyListeners();
  }

  Future<ContactModel> getContactById(int id) => DBHelper.getContactById(id);

  Future<bool> insertContact(ContactModel contactModel) async{
    final rowId = await DBHelper.insertContact(contactModel);
    if(rowId > 0 ){
      contactModel.id = rowId;
      contactList.add(contactModel);
      contactList.sort((c1, c2) => c1.name.compareTo(c2.name));
      notifyListeners();
      return true;
    }
    return false;
  }

  updateFavorite(int id, bool favorite, int index) async {
    final value = favorite ? 0 : 1;
    final rowId = await DBHelper.updateFavorite(id, value);
    if(rowId > 0) {
      contactList[index].favourite = !contactList[index].favourite;
      notifyListeners();
    }
  }

  deleteContact(int id ) async{
    final deleteRowId = await DBHelper.deleteContact(id);
    if(deleteRowId > 0){
      contactList.removeWhere((element) => element.id == id);
      notifyListeners();

    }
  }

}