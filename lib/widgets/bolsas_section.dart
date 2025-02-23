import 'package:flutter/material.dart';
import '../models/bolsa.dart';
import 'bolsa_card.dart';

class BolsasSection extends StatelessWidget {
  final List<Bolsa> bolsas;

  const BolsasSection({super.key, required this.bolsas});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bolsas de Valores',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: bolsas
              .map((bolsa) => BolsaCard(bolsa: bolsa))
              .toList(),
        ),
      ],
    );
  }
}