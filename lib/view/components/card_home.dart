import 'dart:math';

import 'package:conhecafb/model/ponto_turistico.dart';
import 'package:conhecafb/view/detalhes.dart';
import 'package:flutter/material.dart';

class CustomCardHome extends StatelessWidget {
  final PontoTuristico ponto;
  String? imagem;

  final List<String> imagens = [
    'images/avenida_paulista.jpg',
    'images/baia_sancho.jpg',
    'images/centro_historico_paraty.jpg',
    'images/centro_historico_porto_seguro.jpg',
    'images/cristo_redentor.jpg',
    'images/elevador_lacerda.jpg',
    'images/ibirapuera.jpg',
    'images/ilha_grande.jpg',
    'images/lago_furnas.jpg',
    'images/pao_de_acucar.jpg',
    'images/pelourinhos.jpg',
    'images/piscinas_naturais_porto_galinhas.jpg'
  ];

  CustomCardHome(PontoTuristico this.ponto) {
    imagem = imagens[Random().nextInt(12)];
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => DetalhesPontoTuristico(ponto)),
            (route) => false);
      },
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  image: DecorationImage(
                    image: AssetImage(imagem!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
                        child: Text(
                          ponto.nome!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                        child: Text(
                          '${ponto.endereco!.cidade!.estado!.nome} - ${ponto.endereco!.cidade!.estado!.uf}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
