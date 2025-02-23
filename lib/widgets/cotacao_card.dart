import 'package:flutter/material.dart';
import '../models/cotacao.dart';

class CotacaoCard extends StatelessWidget {
  final Cotacao cotacao;

  const CotacaoCard({super.key, required this.cotacao});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              cotacao.codigo,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Compra: ${cotacao.compra?.toStringAsFixed(4) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Venda: ${cotacao.venda?.toStringAsFixed(4) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Variação: ${cotacao.variacao?.toStringAsFixed(2) ?? 'N/A'}%',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}