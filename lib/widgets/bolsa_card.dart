import 'package:flutter/material.dart';
import '../models/bolsa.dart';

class BolsaCard extends StatelessWidget {
  final Bolsa bolsa;

  const BolsaCard({super.key, required this.bolsa});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 150, // Largura fixa para o card
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bolsa.nome,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              bolsa.localizacao,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pontos: ${bolsa.pontos?.toStringAsFixed(2) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Variação: ${bolsa.variacao?.toStringAsFixed(2) ?? 'N/A'}%',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}