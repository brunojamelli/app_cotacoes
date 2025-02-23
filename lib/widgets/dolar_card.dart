import 'package:flutter/material.dart';
import '../models/cotacao.dart';

class DolarCard extends StatelessWidget {
  final Cotacao dolar;

  const DolarCard({super.key, required this.dolar});

  @override
  Widget build(BuildContext context) {
    final Color variacaoColor =
        (dolar.variacao ?? 0) >= 0 ? Colors.green : Colors.red;
    final String variacaoSymbol =
        (dolar.variacao ?? 0) >= 0 ? '+' : '-';

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity, 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            const Text(
              'Dólar',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Compra: R\$ ${dolar.compra?.toStringAsFixed(4) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Venda: R\$ ${dolar.venda?.toStringAsFixed(4) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Variação: $variacaoSymbol${dolar.variacao?.toStringAsFixed(2) ?? 'N/A'}%',
              style: TextStyle(
                fontSize: 16,
                color: variacaoColor, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}