import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conhecafb/model/usuario.dart';
import 'package:conhecafb/view/pagina_principal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroUsuario extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final mask = MaskTextInputFormatter(mask: '##/##/####');

  Usuario usuario = Usuario();

  Future<void> _cadastrarUsuario(BuildContext context) async {
    FormState? formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      String nomeCompleto = usuario.nome!;
      nomeCompleto += usuario.sobrenome?.isNotEmpty ?? false 
        ? ' ' + usuario.sobrenome! 
        : '';
      try {
        await auth.createUserWithEmailAndPassword(
            email: usuario.email!, password: usuario.senha!);
        await auth.currentUser?.updateDisplayName(nomeCompleto);
        usuario.uid = auth.currentUser?.uid;
        usuario.dataCriacao = DateTime.now();
        firestore.collection("usuarios").doc(usuario.uid).set({
          'nome': usuario.nome,
          'sobrenome': usuario.sobrenome,
          'email': usuario.email,
          'senha': usuario.senha,
          'dataCriacao': usuario.dataCriacao,
          'dataNascimento': usuario.dataNascimento,
          'status': usuario.status
        });
        await Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => PaginaPrincipal()),
            (route) => false);
        });
        
      } on FirebaseAuthException catch (exp) {
        print('Crendenciais Invalidas!');
        print(exp.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/principal');
          },
        ),
        title: const Text("Cadastro de Usuário"),
        actions: [],
        backgroundColor: Colors.lightGreen[900],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nome",
                      ),
                      onSaved: (value) => usuario.nome = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Sobrenome",
                      ),
                      onSaved: (value) => usuario.sobrenome = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "E-mail",
                ),
                onSaved: (value) => usuario.email = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Senha",
                ),
                onSaved: (value) => usuario.senha = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [mask],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Data de Nascimento",
                    hintText: 'dd/mm/yyyy',
                  ),
                  onSaved: (value) {
                    var partes = value!.split('/');
                    int dia = int.parse(partes[0]);
                    int mes = int.parse(partes[1]);
                    int ano = int.parse(partes[2]);
                    usuario.dataNascimento = DateTime(ano, mes, dia);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo obrigatório";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen[900],
                  ),
                  child: const Text(
                    "Cadastrar-se",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onPressed: () {
                    _cadastrarUsuario(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuário cadastrado com sucesso.'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
