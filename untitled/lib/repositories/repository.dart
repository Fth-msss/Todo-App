import 'package:sqflite/sqflite.dart';
import 'package:untitled/repositories/database_connection.dart';

class Repository{
  DatabaseConnection? _databaseConnection;

  Repository(){
  //initialize db connection
  //1.29.22
  _databaseConnection=DatabaseConnection();
}
static Database? _database;
Future<Database?> get database async{
  if(_database !=null) return _database;
  _database ??= await _databaseConnection?.setDatabase();
  return _database;
}
//insert data to table
insertData(table,data)async{
  var connection=await database;
  return await connection?.insert(table, data);
}
//read data from table
readData(table)async{
  var connection =await database;
  return await connection?.query(table);//1.54.56
}
  readDataById(table,itemId)async{
  var connection=await database;
  return await connection?.query(table,
  where: 'id=?',whereArgs:[itemId] );
  }
  updateData(table,data)async{
  var connection=await database;
  return await connection?.update(table,data,where: 'id=?',whereArgs: [data['id']]);
  }
  deleteData(table,itemId)async{
    var connection=await database;
    return await connection?.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }
  
  //read data from table 
readDataByColumnName( table, columnName, columnValue) async{
  var connection = await database;
  return await connection
  ?.query(table,where: '$columnName=?',whereArgs: [columnValue]);
}
}