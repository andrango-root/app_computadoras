import 'package:flutter/material.dart';
import 'package:sqflite_example/database/computer_dao.dart';
import 'package:sqflite_example/models/computer_model.dart';

class AddComputerScreen extends StatelessWidget {
  final processorController = TextEditingController();
  final hardDiskController = TextEditingController();
  final ramController = TextEditingController();
  final dao = ComputerDao();

  AddComputerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Computadora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: processorController,
              decoration: const InputDecoration(labelText: 'Procesador'),
            ),
            TextField(
              controller: hardDiskController,
              decoration: const InputDecoration(labelText: 'Disco Duro'),
            ),
            TextField(
              controller: ramController,
              decoration: const InputDecoration(labelText: 'RAM'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final computer = ComputerModel(
                  processor: processorController.text,
                  hardDisk: hardDiskController.text,
                  ram: ramController.text,
                );
                await dao.insert(computer);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Agregar'),
            )
          ],
        ),
      ),
    );
  }
}
