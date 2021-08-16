import 'package:ChallengeApp/Model/detailModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String todoTable = 'todo_table';
  String id = 'id';
  String channelname = 'channelname';
  String title = 'title';
  String high_thumbnail = 'high thumbnail';
  String low_thumbnail = 'low thumbnail';
  String medium_thumbnail = 'medium thumbnail';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'todos.db';

		// Open/create the database at a given path
		var todosDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return todosDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $todoTable($id TEXT, $channelname TEXT, '
				'$title TEXT, $high_thumbnail TEXT, $low_thumbnail TEXT, $medium_thumbnail TEXT)');
	}

	// Fetch Operation: Get all todo objects from database
	Future<List<Map<String, dynamic>>> getTodoMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
		var result = await db.query(todoTable, orderBy: '$title ASC');
		return result;
	}

	// Insert Operation: Insert a todo object to database
	Future<int> insertTodo(DetailModel todo) async {
		Database db = await this.database;
		var result = await db.insert(todoTable, todo.toMap());
		return result;
	}

	// Update Operation: Update a todo object and save it to database
	Future<int> updateTodo(DetailModel todo) async {
		var db = await this.database;
		var result = await db.update(todoTable, todo.toMap());
		return result;
	}

  	Future<int> updateTodoCompleted(DetailModel todo) async {
		var db = await this.database;
		var result = await db.update(todoTable, todo.toMap(), where: '$id = ?', whereArgs: [todo.id]);
		return result;
	}

	// Delete Operation: Delete a todo object from database
	Future<int> deleteTodo(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $todoTable WHERE $id = $id');
		return result;
	}

	// Get number of todo objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $todoTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
	Future<List<DetailModel>> getTodoList() async {

		var todoMapList = await getTodoMapList(); // Get 'Map List' from database
		int count = todoMapList.length;         // Count the number of map entries in db table

		List<DetailModel> todoList = List<DetailModel>();
		// For loop to create a 'todo List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			todoList.add(DetailModel.fromMapObject(todoMapList[i]));
		}

		return todoList;
	}

}







