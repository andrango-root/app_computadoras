class ComputerModel {
  final int? id;
  final String processor;
  final String hardDisk;
  final String ram;

  ComputerModel(
      {this.id,
      required this.processor,
      required this.hardDisk,
      required this.ram});

  // Convertir el objeto a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'processor': processor,
      'hardDisk': hardDisk,
      'ram': ram,
    };
  }

  // Convertir de Map a ComputerModel
  factory ComputerModel.fromMap(Map<String, dynamic> map) {
    return ComputerModel(
      id: map['id'],
      processor: map['processor'],
      hardDisk: map['hardDisk'],
      ram: map['ram'],
    );
  }

  // Copiar con cambios
  ComputerModel copyWith(
      {int? id, String? processor, String? hardDisk, String? ram}) {
    return ComputerModel(
      id: id ?? this.id,
      processor: processor ?? this.processor,
      hardDisk: hardDisk ?? this.hardDisk,
      ram: ram ?? this.ram,
    );
  }
}
