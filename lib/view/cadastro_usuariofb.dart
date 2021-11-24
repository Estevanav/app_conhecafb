import 'package:flutter/material.dart';
import 'package:conhecafb/model/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';

class CadastroUsuarioFb extends StatefulWidget {
  @override
  _CadastroUsuarioFbState createState() => _CadastroUsuarioFbState();
}

class _CadastroUsuarioFbState extends State<CadastroUsuarioFb> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Usuario usuario = Usuario();

  Future<void> _cadastrarUsuario(BuildContext context) async {
    FormState? formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        await auth.createUserWithEmailAndPassword(email: usuario.email!, password: usuario.senha!);
        await auth.currentUser?.updateDisplayName(usuario.nome);
        usuario.uid = auth.currentUser?.uid;
        usuario.dataCriacao = DateTime.now();
        firestore.collection("usuarios").doc(usuario.uid)
        .set({
          'nome':           usuario.nome,
          'sobrenome' :     usuario.sobrenome,
          'email':          usuario.email,
          'senha':          usuario.senha,
          'dataCriacao':    usuario.dataCriacao,
          'dataNascimento': usuario.dataNascimento,
          'status':         usuario.status          
        });

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => ChatPage()), (route) => false);
      } on FirebaseAuthException catch (exp) {
        print('Crendenciais Invalidas!');
        print(exp.message);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Usuário')),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
                onSaved: (value) => usuario.nome = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Sobrenome",
                ),
                onSaved: (value) => usuario.sobrenome = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "E-mail",
                ),
                onSaved: (value) => usuario.email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Senha",
                ),
                onSaved: (value) => usuario.senha = value,
                validator: (value) {
                  if (value!.length < 6) {
                    return "A senha deve conter no mínimo 6 caracteres.";
                  }
                },
                obscureText: true,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Data nascimento",
                  hintText: 'dd/mm/yyyy',
                ),
                onSaved: (value) {
                  var partes = value!.split('/');
                  int dia = int.parse(partes[0]);
                  int mes = int.parse(partes[1]);
                  int ano = int.parse(partes[2]);
                  usuario.dataNascimento = DateTime(ano, mes, dia);
                  //usuario.dataNascimento = DateFormat('dd/mm/yyyy', 'pt-BR').parse(value!);

                } 
              ),
              
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _cadastrarUsuario(context),
                  child: const Text("Cadastrar"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Já tem cadastro, faça login.")),
            ],
          ),
        ),
      ),
    );
  }
}
