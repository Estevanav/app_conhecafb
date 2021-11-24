import 'package:conhecafb/model/cidade.dart';

class Endereco {
  String? logradouro;
  String? numero;
  String? cep;
  String? complemento;
  String? referencia;
  Cidade? cidade;

  Endereco({
    this.logradouro,
    this.numero,
    this.cep,
    this.complemento,
    this.referencia,
    this.cidade,
  });

  factory Endereco.fromJson(Map<String, Object?> json) {
    return Endereco(
      logradouro: json['logradouro'] as String,
      numero: json['numero'] as String,
      cep: json['cep'] as String,
      complemento:  json['complemento'] as String,
      referencia: json['referencia'] as String,
      cidade: Cidade.fromJson(json['cidade'] as Map<String, Object?>),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'logradouro': logradouro,
      'numero': numero,
      'cep': cep,
      'complemento': complemento,
      'referencia': referencia,
      'cidade': cidade!.toJson(),
    };
  }
}
