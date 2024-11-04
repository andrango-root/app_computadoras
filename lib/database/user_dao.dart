import 'package:sqflite_example/database/database_helper.dart';
import 'package:sqflite_example/models/user_model.dart';

class UserDao {
  // Método para leer todos los usuarios
  Future<List<UserModel>> readAll() async {
    final db = DatabaseHelper.instance.db;
    final data = await db.query('users');
    return data.map((e) => UserModel.fromMap(e)).toList();
  }

  // Método para insertar un nuevo usuario
  Future<int> insert(UserModel user) async {
    final db = DatabaseHelper.instance.db;
    return await db.insert('users', {'name': user.name});
  }

  // Método para actualizar un usuario existente
  Future<void> update(UserModel user) async {
    final db = DatabaseHelper.instance.db;
    await db
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  // Método para eliminar un usuario
  Future<void> delete(UserModel user) async {
    final db = DatabaseHelper.instance.db;
    await db.delete('users', where: 'id = ?', whereArgs: [user.id]);
  }
}
