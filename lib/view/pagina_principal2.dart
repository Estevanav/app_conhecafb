// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:conhecafb/model/ponto_turistico.dart';
// import 'package:conhecafb/model/usuario.dart';
// import 'package:conhecafb/view/components/card_home.dart';
// import 'package:conhecafb/view/view_dto_fb/detalhe_ponto_dto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class PaginaPrincipal extends StatefulWidget {
//   @override
//   _PaginaPrincipalState createState() => _PaginaPrincipalState();
// }

// class _PaginaPrincipalState extends State<PaginaPrincipal> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   final Stream<QuerySnapshot> _pontosStream =
//       FirebaseFirestore.instance.collection('pontos_turisticos').snapshots();

//   List<Usuario> listaUsuarios = [];

//   _PaginaPrincipalState() {
//     escreverTitulo();
//     //carregarUsuarios();
//   }

//   Future<void> carregarUsuarios() async {
//     await carregarUsuariosFirestore();
//   }

//   String titulo = "Página Principal";

//   late int _selectedIndex = 0;

//   void escreverTitulo() {
//     if (auth.currentUser != null) {
//       titulo = 'Olá ${auth.currentUser!.displayName}';
//     } else {
//       titulo = "Página Principal";
//     }
//   }

//   Future<void> carregarUsuariosFirestore() async {
//     await FirebaseFirestore.instance
//         .collection('usuarios')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         listaUsuarios.add(Usuario.fromJson(doc.data() as Map<String, Object?>));
//       });
//     });
//   }

//   Future<void> _logout(BuildContext context) async {
//     await auth.signOut();
//     Navigator.of(context).pushReplacementNamed('/principal');
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (index == 1) {
//         String rota = "";
//         if (auth.currentUser != null) {
//           rota = '/cadastroPonto';
//         } else {
//           rota = '/login';
//         }
//         Navigator.of(context).pushReplacementNamed(rota);
//       } else if (index == 3) {
//         Navigator.of(context).pushReplacementNamed('/login');
//       }
//     });
//   }

//   final detalheDto = DetalhePontoDto();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         // ---------------------------- AppBar -------------

//         appBar: AppBar(
//           toolbarHeight: 65,
//           title: Text(titulo),
//           actions: [
//             IconButton(
//               icon: const Icon(
//                 Icons.logout,
//               ),
//               tooltip: 'Sair',
//               onPressed: () => _logout(context),
//             ),
//           ],
//           backgroundColor: Colors.lightGreen[900],
//         ),

//         // ---------------------------- Body -------------

//         body: Column(
//           children: [
//             const Flexible(
//               flex: 1,
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Pesquise aqui seu ponto turístico',
//                     prefixIcon: Icon(Icons.search),
//                   ),
//                 ),
//               ),
//             ),
//             Flexible(
//               flex: 12,
//               child: FutureBuilder<bool>(
//                   future: detalheDto.getTudoProntoCarregado(),
//                   builder: (BuildContext context, snap) {
//                     if (snap.hasError) {
//                       return Text(
//                         'Something went wrong',
//                         textDirection: TextDirection.ltr,
//                       );
//                     }
//                     //if ( ! snap.hasData ) {
//                     //  return Center(child: CircularProgressIndicator());
//                     //}

//                     List<CustomCardHome> listaCardPontos =
//                         detalheDto.pontosTuristicos.map((ponto) {
//                         var usuario = detalheDto.getUsuarioFrom(ponto);
//                         return CustomCardHome(ponto, usuario!);
//                     }).toList();

//                     return GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 10,
//                         crossAxisSpacing: 10,
//                       ),
//                       itemCount: listaCardPontos.length,
//                       primary: false,
//                       padding: const EdgeInsets.all(20),
//                       itemBuilder: (context, index) {
//                         return listaCardPontos[index];
//                       },
//                     );

//                     // return GridView.count(
//                     //   primary: false,
//                     //   padding: const EdgeInsets.all(20),
//                     //   crossAxisSpacing: 10,
//                     //   mainAxisSpacing: 10,
//                     //   crossAxisCount: 2,
//                     //   children: listaCardPontos,
//                     // );
//                   }),
//             ),
//           ],
//         ),

//         // ---------------------------- BottomNavigationBar -------------

//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//               backgroundColor: Colors.lightGreen[900],
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add),
//               label: 'Novo local',
//               backgroundColor: Colors.lightGreen[900],
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.map),
//               label: 'Mapa',
//               backgroundColor: Colors.lightGreen[900],
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Perfil',
//               backgroundColor: Colors.lightGreen[900],
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.white,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }
