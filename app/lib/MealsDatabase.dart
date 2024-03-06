import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class Meal {
  final int code;
  final String name;
  final int calories;
  final int lipids;
  final int carbohydrates;
  final int proteins;

  Meal({
    required this.code,
    required this.name,
    required this.calories,
    required this.lipids,
    required this.carbohydrates,
    required this.proteins});

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'calories': calories,
      'lipids': lipids,
      'carbohydrates': carbohydrates,
      'proteins': proteins,
    };
  }
}

class MealsDatabase {

  static const table = 'meals';

  static const columnCode = 'code';
  static const columnName = 'name';
  static const columnCalories = 'calories';
  static const columnLipids = 'lipids';
  static const columnCarbohydrates = 'carbohydrates';
  static const columnProteins = 'proteins';

  MealsDatabase._privateConstructor();
  static final MealsDatabase instance = MealsDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await initialize();
    return _database!;
  }

  initialize() async {
    final dbPath = await getDatabasesPath();
    final assetPath = join('assets', 'meals.db');
    final fullDbPath = join(dbPath, 'meals.db');

    await deleteDatabase(fullDbPath); // Optional: Delete existing database

    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    await File(fullDbPath).writeAsBytes(bytes);

    return await openDatabase(fullDbPath);
    }

  Future<List<dynamic>> readAll() async {
    final db = await instance.database;
    const orderBy = 'code ASC';
    final result = await db.query(table, orderBy: orderBy);
    return result;
  }

  Future<List<dynamic>> searchByName(String name) async {
    final db = await instance.database;
    final result = await db.query(table, where: 'name LIKE ?', whereArgs: ['%$name%']);
    return result;
  }

}



