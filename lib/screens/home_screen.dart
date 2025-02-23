import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/cotacao.dart';
import '../models/bolsa.dart';
import '../widgets/moedas_section.dart';
import '../widgets/bolsas_section.dart';
import '../widgets/loading_widget.dart';
import '../widgets/custom_error_widget.dart';

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
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return CustomErrorWidget(message: snapshot.error.toString());
          }

          final cotacoes = snapshot.data!['cotacoes'] as List<Cotacao>;
          final bolsas = snapshot.data!['bolsas'] as List<Bolsa>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                MoedasSection(cotacoes: cotacoes),
                const SizedBox(height: 20),
                BolsasSection(bolsas: bolsas),
              ],
            ),
          );
        },
      ),
    );
  }
}