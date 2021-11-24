import 'package:conhecafb/view/cadastro_usuariofb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class LoginFb extends StatefulWidget {
  @override
  _LoginFbState createState() => _LoginFbState();
}

class _LoginFbState extends State<LoginFb> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email, senha;

  Future<void> _login(BuildContext context) async {
    FormState? formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        await auth.signInWithEmailAndPassword(email: email!, password: senha!);
        //Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatPage()));
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
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "E-mail",
                ),
                onSaved: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Senha",
                ),
                onSaved: (value) => senha = value,
                validator: (value) {
                  if (value!.length < 6) {
                    return "A senha deve conter no mínimo 6 caracteres.";
                  }
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  child: const Text("Entrar"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CadastroUsuarioFb()));
                  },
                  child: const Text("Novo usuário, cadastre-se aqui.")),
            ],
          ),
        ),
      ),
    );
  }
}
