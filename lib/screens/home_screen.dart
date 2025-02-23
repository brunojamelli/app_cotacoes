import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/cotacao.dart';
import '../models/bolsa.dart';
import '../widgets/cotacao_card.dart';
import '../widgets/bolsa_card.dart';

class HomeScreen extends StatefulWidget {
  final ApiService apiService;

  const HomeScreen({super.key, required this.apiService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, List<dynamic>>> dadosFinanceiros;

  @override
  void initState() {
    super.initState();
    dadosFinanceiros = widget.apiService.getDadosOrganizados();
  }

  void _refreshData() {
    setState(() {
      dadosFinanceiros = widget.apiService.getDadosOrganizados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cotações e Bolsas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, List<dynamic>>>(
        future: dadosFinanceiros,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final cotacoes = snapshot.data!['cotacoes'] as List<Cotacao>;
          final bolsas = snapshot.data!['bolsas'] as List<Bolsa>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
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
                const SizedBox(height: 20),
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
            ),
          );
        },
      ),
    );
  }
}