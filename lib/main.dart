import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> dadosFinanceiros;

  @override
  void initState() {
    super.initState();
    dadosFinanceiros = _fetchDadosFinanceiros();
  }

  Future<Map<String, dynamic>> _fetchDadosFinanceiros() async {
    try {
      final res = await http.get(
        Uri.parse('https://api.hgbrasil.com/finance/quotations'),
      );

      if (res.statusCode != 200) {
        throw 'Erro ao carregar os dados';
      }

      return jsonDecode(res.body);
    } catch (e) {
      throw 'Erro: $e';
    }
  }

  void _refreshData() {
    setState(() {
      dadosFinanceiros = _fetchDadosFinanceiros();
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
      body: FutureBuilder<Map<String, dynamic>>(
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

          final dados = snapshot.data!['results'];
          final moedas = dados['currencies'];
          final bolsas = dados['stocks'];

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
                    children: moedas.entries
                        .where((entry) => entry.key != 'source')
                        .map((entry) {
                          final codigo = entry.key;
                          final detalhes = entry.value;
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
                                    codigo,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Compra: ${detalhes['buy']?.toStringAsFixed(4) ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Venda: ${detalhes['sell']?.toStringAsFixed(4) ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Variação: ${detalhes['variation']?.toStringAsFixed(2) ?? 'N/A'}%',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(), // Correção aqui
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
                  children: bolsas.entries.map((entry) {
                    final codigo = entry.key;
                    final detalhes = entry.value;
                    return Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detalhes['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              detalhes['location'],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Pontos: ${detalhes['points']?.toStringAsFixed(2) ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Variação: ${detalhes['variation']?.toStringAsFixed(2) ?? 'N/A'}%',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(), // Correção aqui
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}