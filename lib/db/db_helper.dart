
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact_model.dart';


class DBHelper{
  static const String createTableContact='''
  create table $tableContact(
  $tableContactColId integer primary key,
  $tableContactColName text,
  $tableContactColNumber text,
  $tableContactColEmail text,
  $tableContactColAddress text,
  $tableContactColDob text,
  $tableContactColGender text,
  $tableContactColImage text,
  $tableContactColWebsite text,
  $tableContactColFav integer
  )
  ''';

  static Future<Database> open() async{
    final rootPath = await getDatabasesPath();
    final dbPath =join(rootPath,'contact.db');

    return openDatabase(dbPath, version: 2, onCreate:(db, version){
      db.execute(createTableContact);
    }, onUpgrade: (db, oldV, newV){
      if(newV ==2){
        db.execute('alter table $tableContact add column $tableContactColWebsite text');
    }
    } );
  }
  static Future<int> insertContact(ContactModel contactModel) async{
    final db = await open();
   return db.insert(tableContact, contactModel.toMap());
  }

  static Future<List<ContactModel>> getAllContacts()  async {
  final db = await open();
  final mapList = await db.query(tableContact);
  return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  static Future<List<ContactModel>> getAllFavoriteContacts()  async {
    final db = await open();
    final mapList = await db.query(
      tableContact,
      where: '$tableContactColFav =?',
      whereArgs: [1], orderBy: '$tableContactColName asc'
    );
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  static Future<ContactModel> getContactById(int id) async{
    final db = await open();
    final mapList = await db.query(
        tableContact,
        where: '$tableContactColId = ?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }

  static Future<int> updateFavorite(int id, int value) async{
    final db = await open();
    return db.update(tableContact,
        {tableContactColFav : value},
        where: '$tableContactColId = ?', whereArgs: [id]);
  }

  static Future<int> deleteContact(int id) async{
    final db = await open();
    return db.delete(tableContact,
        where: '$tableContactColId = ?', whereArgs: [id]);
  }



}