import 'package:sqflite_example/database/database_helper.dart';
import 'package:sqflite_example/models/computer_model.dart';

class ComputerDao {
  // Método para insertar una computadora en la base de datos
  Future<int> insert(ComputerModel computer) async {
    final db = DatabaseHelper.instance.db;
    return await db.insert('computers', computer.toMap());
  }

  // Método para leer todas las computadoras de la base de datos
  Future<List<ComputerModel>> readAll() async {
    final db = DatabaseHelper.instance.db;
    final maps = await db.query('computers');

    return List.generate(maps.length, (i) {
      return ComputerModel.fromMap(maps[i]);
    });
  }

  // Método para eliminar una computadora de la base de datos
  Future<int> delete(ComputerModel computer) async {
    final db = DatabaseHelper.instance.db;
    return await db.delete(
      'computers',
      where: 'id = ?',
      whereArgs: [computer.id],
    );
  }

  // Método para actualizar una computadora en la base de datos
  Future<int> update(ComputerModel computer) async {
    final db = DatabaseHelper.instance.db;
    return await db.update(
      'computers',
      computer.toMap(),
      where: 'id = ?',
      whereArgs: [computer.id],
    );
  }
}
