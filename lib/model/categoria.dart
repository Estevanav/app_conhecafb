import 'package:cloud_firestore/cloud_firestore.dart';

class Categoria {
  String? uid;
  String? tipo;
  DocumentReference? reference;

  Categoria({this.tipo});

  factory Categoria.fromSnapshot(DocumentSnapshot<Categoria> snapshot) {
    Categoria novaCategoria = snapshot.data()!;
    novaCategoria.reference = snapshot.reference;
    return novaCategoria;
  }

  factory Categoria.fromJson(Map<String, Object?> json) =>
      _categoriaFromJson(json);

  Map<String, dynamic> toJson() => _categoriaToJson(this);

  @override
  String toString() => '${tipo}';
}

Categoria _categoriaFromJson(Map<String, Object?> json) {
  return Categoria(
    //uid: json['uid'] == null ? null : json['uid'] as String,
    tipo: json['tipo'] as String,
  );
}

Map<String, Object?> _categoriaToJson(Categoria instance) {
  return {
    //'uid': instance.uid,
    'tipo': instance.tipo,
  };
}
