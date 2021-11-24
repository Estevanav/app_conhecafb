import 'package:flutter/material.dart';

class CardImagem extends StatelessWidget {
  final String imagem;

  CardImagem(this.imagem);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          image: DecorationImage(
            image: AssetImage(imagem),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}