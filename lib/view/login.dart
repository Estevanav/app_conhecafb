import 'dart:ui';

import 'package:conhecafb/view/pagina_principal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            MaterialPageRoute(builder: (_) => PaginaPrincipal()),
            (route) => false);
      } on FirebaseAuthException catch (exp) {
        print('Crendenciais Invalidas!');
        print(exp.message);
      }
    }
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: SizedBox(
        // width: MediaQuery.of(context)
        //     .size
        //     .width, //faz parte do SigleChieldScrollView
        // height: MediaQuery.of(context)
        //     .size
        //     .height, //faz parte do SigleChieldScrollView
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Conheça!',
                  style: TextStyle(
                      letterSpacing: 8,
                      color: Colors.lightGreen[400],
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'E-Mail',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) => email = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo obrigatório.";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) => senha = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo obrigatório.";
                          }
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _login(context),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen[900],
                          ),
                          child: const Text(
                            "Entrar",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/cadastroUsuario');
                          },
                          child: const Text(
                            'Não tenho conta, quero realizar cadastro.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/principal'),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          _body(),
        ],
      ),
    );
  }
}
