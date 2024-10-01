import 'package:atividade03/transacoesPage.dart';
import 'package:flutter/material.dart';

class AplicacaoBancaria extends StatelessWidget {
  const AplicacaoBancaria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransacoesPage(),
    );
  }
}
