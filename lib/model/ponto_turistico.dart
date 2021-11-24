import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conhecafb/model/categoria.dart';
import 'package:conhecafb/model/endereco.dart';

class PontoTuristico {
  String? uid;
  String? nome;
  String? descricao;
  double? latitude;
  double? longitude;  
  DateTime? dataCriacao;
  String? usuarioUid;
  String? usuarioNome;
  
  Endereco? endereco;
  List<Categoria>? categorias;

  PontoTuristico({
    this.uid,
    this.nome,
    this.descricao,
    this.latitude,
    this.longitude,
    this.dataCriacao,
    this.usuarioUid,
    this.usuarioNome,
    this.endereco,
    this.categorias    
  });

  factory PontoTuristico.fromJson(Map<String, Object?> json) {
    /*
    List lista = (json['categorias'] as List);
    List<Categoria> cats = [];
    lista.forEach((t) => cats.add(Categoria(tipo: t)));
    List<Categoria> cats2 = lista
      .map((e) => Categoria(tipo: e))
      .toList();
    */

    return PontoTuristico(
        //uid: json['uid'] as String,
        nome: json['nome'] as String,
        descricao: json['descricao'] as String,
        dataCriacao: (json['dataCriacao'] as Timestamp).toDate(),
        usuarioUid: json['usuario.uid'] as String,
        usuarioNome: json['usuario.nome'] as String,
        endereco: Endereco.fromJson(json['endereco'] as Map<String, Object?>),
        categorias: (json['categorias'] as List)
          .map((tipo) => Categoria(tipo: tipo))
          .toList()
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'dataCriacao': dataCriacao,
      'usuario.uid': usuarioUid,
      'usuario.nome': usuarioNome,
      'endereco': endereco!.toJson(),
      'categorias': categorias!.map((c) => c.tipo).toList()

      // "latitude": latitude,
      // "longitude": longitude,
      //"usuario": usuario,
      //"categorias": categorias,
    };
  }
}
