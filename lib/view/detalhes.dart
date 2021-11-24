import 'package:conhecafb/model/cidade.dart';
import 'package:conhecafb/model/endereco.dart';
import 'package:conhecafb/model/estado.dart';
import 'package:conhecafb/model/ponto_turistico.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetalhesPontoTuristico extends StatefulWidget {
  DetalhesPontoTuristico(this.ponto) {
    nomeEstado = ponto.endereco!.cidade!.estado!.nome;
    ufEstado = ponto.endereco!.cidade!.estado!.uf;
  }
  PontoTuristico ponto;

  String? nomeEstado;
  String? ufEstado;
  Endereco? endereco;

  @override
  DetalhesPontoTuristicoState createState() => DetalhesPontoTuristicoState();
}

class DetalhesPontoTuristicoState extends State<DetalhesPontoTuristico> {
  CarouselController buttonCarouselController = CarouselController();
  int indexAtual = 0;
  final imagens = [
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
    'images/piscinas_naturais_porto_galinhas.jpg',
  ];
  Widget _buildImagem(String imagem, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: const BoxDecoration(color: Colors.amber),
      child: Image.asset(
        imagem,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  String getLogradouroNumeroComplemento() {
    String? str = '';
    Endereco? endereco = widget.ponto.endereco;

    if (endereco != null) {
      String? numero = endereco.numero;
      String? logradouro = endereco.logradouro;
      String? complemento = endereco.complemento;

      if (logradouro?.isNotEmpty ?? false) {
        str += logradouro!;

        if (numero?.isNotEmpty ?? false) {
          str += ', ' + numero!;
        }
        if (complemento?.isNotEmpty ?? false) {
          str += ', ' + complemento!;
        }
      } else if (numero?.isNotEmpty ?? false) {
        str = numero!;
        if (complemento?.isNotEmpty ?? false) {
          str += ', ' + complemento!;
        }
      } else if (complemento?.isNotEmpty ?? false) {
        str += complemento!;
      }
    }
    return str;
  }

  String getCepCidadeUf() {
    String str = '';
    Endereco? endereco = widget.ponto.endereco;
    if (endereco != null) {
      String? cep = endereco.cep;
      Cidade? cidade = endereco.cidade;

      if (cep?.isNotEmpty ?? false) {
        str += cep!;

        if (cidade != null) {
          if (cidade.nome?.isNotEmpty ?? false) {
            str += ' - ' + cidade.nome!;
            Estado? estado = cidade.estado;
            if (estado != null) {
              if (estado.uf.isNotEmpty) {
                str += '/' + estado.uf;
              }
            }
          }
        }
      } else if (cidade != null) {
        if (cidade.nome?.isNotEmpty ?? false) {
          str += ' - ' + cidade.nome!;
          Estado? estado = cidade.estado;
          if (estado != null) {
            if (estado.uf.isNotEmpty) {
              str += '/' + estado.uf;
            }
          }
        }
      }
    }
    return str;
  }

  String getReferencia() {
    String str = '';
    Endereco? endereco = widget.ponto.endereco;
    if (endereco != null) {
      String? referencia = endereco.referencia;
      str = referencia?.isNotEmpty ?? false
          ? 'Ponto de referência: ' + referencia!
          : '';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/principal');
            },
          ),
          title: Text("Detalhes do Ponto Turístico"),
          actions: [],
          backgroundColor: Colors.lightGreen[900],
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.lightGreen[900],
                  child: CarouselSlider.builder(
                    //carouselController: buttonCarouselController,
                    itemBuilder: (context, index, realIndex) {
                      var imagem = imagens[index];
                      return _buildImagem(imagem, index);
                    },
                    carouselController: buttonCarouselController,
                    itemCount: imagens.length,
                    options: CarouselOptions(
                        height: 350,
                        viewportFraction: 1.05,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) =>
                            setState(() => indexAtual = index)),
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: imagens.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            buttonCarouselController.animateToPage(entry.key),
                        child: Container(
                          width: 24.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: indexAtual == entry.key
                                ? Colors.lightGreen[900]
                                : Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.lightGreen[900],
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      color: Colors.lightGreen[400],
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                widget.ponto.nome!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                '${widget.nomeEstado} - ${widget.ufEstado}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '${widget.ponto.descricao}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.lightGreen[400],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'Endereço:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                getLogradouroNumeroComplemento(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                getCepCidadeUf(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                getReferencia(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(Icons.star, color: Colors.black),
                                    Icon(Icons.star, color: Colors.black),
                                    Icon(Icons.star, color: Colors.black),
                                    Icon(Icons.star, color: Colors.black),
                                    Icon(Icons.star, color: Colors.black),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '5/5',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      width: double.infinity,
                                    )),
                                    Text(
                                      'By ${widget.ponto.usuarioNome}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
