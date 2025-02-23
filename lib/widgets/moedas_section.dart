import 'package:flutter/material.dart';
import '../models/cotacao.dart';
import 'cotacao_card.dart';
import 'dolar_card.dart';

class MoedasSection extends StatelessWidget {
  final List<Cotacao> cotacoes;

  const MoedasSection({super.key, required this.cotacoes});

  @override
  Widget build(BuildContext context) {
    final dolar = cotacoes.firstWhere(
      (cotacao) => cotacao.codigo == 'USD',
      orElse: () => Cotacao(
        codigo: 'USD',
        nome: 'Dólar',
        compra: 0.0,
        venda: 0.0,
        variacao: 0.0,
      ),
    );

    final outrasMoedas = cotacoes.where((cotacao) => cotacao.codigo != 'USD').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   'Cotações de Moedas',
        //   style: TextStyle(
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        const SizedBox(height: 8),
        DolarCard(dolar: dolar), 
        const SizedBox(height: 20),
        const Text(
          'Outras Moedas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: outrasMoedas
                .map((cotacao) => CotacaoCard(cotacao: cotacao))
                .toList(),
          ),
        ),
      ],
    );
  }
}