
import 'package:conhecafb/model/estado.dart';

class Cidade {
  String? nome;
  Estado? estado;

  Cidade({this.nome, this.estado});

  factory Cidade.fromJson(Map<String, Object?> json) {
    return Cidade(
      nome: json['nome'] as String,
      estado: Estado.fromJson(json['estado'] as Map<String, Object?>),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'nome': nome,
      'estado': estado!.toJson(),
    };
  }
}