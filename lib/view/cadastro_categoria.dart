import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conhecafb/model/categoria.dart';
import 'package:flutter/material.dart';

class CadastroCategoria extends StatefulWidget {
  @override
  State<CadastroCategoria> createState() => _CadastroCategoriaState();
}

class _CadastroCategoriaState extends State<CadastroCategoria> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController categoriaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Categoria categoria = Categoria();

  Future<void> _cadastrarCategoria(BuildContext context) async {
    FormState? formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        firestore.collection("categorias").add({'tipo': categoria.tipo});
      } on FirebaseException catch (exp) {
        print('Deu pau no cadastro de categoria!');
        print(exp.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/cadastroPonto');
          },
        ),
        title: Text("Cadastro de Categoria"),
        actions: [],
        backgroundColor: Colors.lightGreen[900],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: categoriaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Digite aqui a categoria",
                ),
                onSaved: (value) => categoria.tipo = value,
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
            child: Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen[900],
                ),
                child: Text(
                  "Cadastrar categoria",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  _cadastrarCategoria(context);
                  FormState? formState = _formKey.currentState;
                  String msg = 'Categoria(s) cadastradas com sucesso.';
                  if (!formState!.validate()) {                    
                    msg = 'O campo obrigatório deve ser preenchido.';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                    ),
                  );
                  categoriaController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

