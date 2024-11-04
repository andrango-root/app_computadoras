import 'package:flutter/material.dart';
import 'package:sqflite_example/database/user_dao.dart';
import 'package:sqflite_example/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  List<UserModel> users = [];
  final dao = UserDao();

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  Future<void> _refreshUserList() async {
    final data = await dao.readAll();
    setState(() {
      users = data;
    });
  }

  Future<void> _editUser(UserModel user) async {
    final newName = await _showEditDialog(user.name);
    if (newName != null && newName.isNotEmpty) {
      final updatedUser = user.copyWith(name: newName);
      await dao.update(updatedUser);
      _refreshUserList();
    }
  }

  Future<String?> _showEditDialog(String currentName) async {
    final editController = TextEditingController(text: currentName);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Computadora'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(labelText: 'Nombre'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(editController.text),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Computadoras'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(labelText: 'Nueva Computadora'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final name = controller.text;
                      if (name.isNotEmpty) {
                        UserModel user = UserModel(name: name);
                        final id = await dao.insert(user);
                        user = user.copyWith(id: id);
                        controller.clear();
                        setState(() {
                          users.add(user);
                        });
                      }
                    },
                    child: const Text('Agregar'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    leading: Text('${user.id}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editUser(user),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await dao.delete(user);
                            _refreshUserList();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
