import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conhecafb/model/ponto_turistico.dart';
import 'package:conhecafb/model/usuario.dart';

class DetalhePontoDto {

  List<Usuario> usuarios = [];
  List<PontoTuristico> pontosTuristicos = [];
  

  Future<void> getUsuarios() async {
    await FirebaseFirestore.instance
        .collection('usuarios')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Usuario usuario = Usuario.fromJson(doc.data() as Map<String, Object?>);
        usuario.uid = doc.id;
        usuarios.add(usuario);
      });
    });
  }
  Future<void> getPontosTuristicos() async {
    await FirebaseFirestore.instance
        .collection('pontos_turisticos')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        pontosTuristicos.add(PontoTuristico.fromJson(doc.data() as Map<String, Object?>));
      });
    });
  }
  
  Future<bool> getTudoProntoCarregado() async {
    await getPontosTuristicos();
    await getUsuarios();
    return true;
  }


  Usuario? getUsuarioFrom(PontoTuristico ponto) {
    
    for (var usuario in usuarios) {
      if (usuario.uid == ponto.usuarioUid) {
        return usuario;
      }
    }
    return null;
  }
}