import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? uid;
  String? nome;
  String? sobrenome;
  String? email;
  String? senha;
  DateTime? dataNascimento;
  DateTime? dataCriacao;
  int status;

  Usuario({
      this.uid,
      this.nome,
      this.sobrenome,
      this.email,
      this.senha,
      this.dataNascimento,
      this.dataCriacao,
      this.status = 1});

  factory Usuario.fromJson(Map<String, Object?> json) {
    return Usuario(
      //uid: json['uid'] as String,
      nome: json['nome'] as String,
      sobrenome: json['sobrenome'] as String,
      status: json['status'] as int,
      senha: json['senha'] as String,
      email: json['email'] as String,
      dataNascimento: (json['dataNascimento'] as Timestamp).toDate(),
      dataCriacao: (json['dataCriacao'] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      "nome": nome,
      "sobrenome": sobrenome,
      "senha": senha,
      "email": email,
      "dataNascimento": dataNascimento,
      "dataCriacao": dataCriacao,
    };
  }  

  @override
  String toString() {
    return '${nome} ${sobrenome} E-mail: ${email}';
  } 
}
