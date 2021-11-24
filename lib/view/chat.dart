import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conhecafb/view/loginfb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/usuario.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Usuario? usuario;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');


  Future<void> _logout(BuildContext context) async {
    await auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginFb()), (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          TextButton(
            onPressed: () => _logout(context),
            child: const Text(
              "SAIR",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: usuarios.doc(auth.currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Algo deu errado.");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          Timestamp dataCriacaoTs = data['dataCriacao'];
          Timestamp dataNascimentoTs = data['dataNascimento'];
          usuario = Usuario(
              uid: auth.currentUser!.uid,
              nome: data['nome'],
              sobrenome: data['sobrenome'],
              email: data['email'],
              dataCriacao: dataCriacaoTs.toDate(),
              dataNascimento: dataNascimentoTs.toDate(),
              senha: data['senha'],
              status: data['status']);

          return Text("Olá mister ${usuario!.nome} ${usuario!.sobrenome}\n");
        },
      ),
    );
  }
}
