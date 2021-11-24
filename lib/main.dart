import 'package:conhecafb/view/cadastro_categoria.dart';
import 'package:conhecafb/view/cadastro_ponto_turistico.dart';
import 'package:conhecafb/view/cadastro_usuario.dart';
import 'package:conhecafb/view/login.dart';
import 'package:conhecafb/view/mapa.dart';
import 'package:conhecafb/view/pagina_principal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());

  //await Firebase.initializeApp();
  //runApp(const MyApp());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  Object? exp = null;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
        exp = e;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      //return SomethingWentWrong();
      print('SomethingWentWrong');
      print(exp);
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const CircularProgressIndicator()],
        ),
      );
    }

    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Upload Image',
      //home: auth.currentUser != null ?  ChatPage() : LoginPage(),
      home: PaginaPrincipal(),
      routes: {
        '/login': (context) => Login(),
        '/cadastroUsuario': (context) => CadastroUsuario(),
        '/cadastroPonto': (context) => CadastroPontoTuristico(),
        '/cadastroCategoria': (context) => CadastroCategoria(),
        '/principal': (context) => PaginaPrincipal(),
        '/mapa': (context) => ScreenMap(),
        //'/detalhe': (context) => DetalhesPontoTuristico(ponto),
        //'/configuracoes': (context) => PaginaConfiguracoes(),
      },
    );
  }
}
