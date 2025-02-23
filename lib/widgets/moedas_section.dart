import 'package:flutter/material.dart';
import '../models/cotacao.dart';
import 'cotacao_card.dart';

class MoedasSection extends StatelessWidget {
  final List<Cotacao> cotacoes;

  const MoedasSection({super.key, required this.cotacoes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cotações de Moedas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: cotacoes
                .map((cotacao) => CotacaoCard(cotacao: cotacao))
                .toList(),
          ),
        ),
      ],
    );
  }
}