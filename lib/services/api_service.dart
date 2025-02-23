import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/cotacao.dart';
import '../models/bolsa.dart';

class ApiService {
  Future<Map<String, dynamic>> fetchDadosFinanceiros() async {
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

  Future<Map<String, List<dynamic>>> getDadosOrganizados() async {
    final data = await fetchDadosFinanceiros();
    final moedas = data['results']['currencies'] as Map<String, dynamic>;
    final bolsas = data['results']['stocks'] as Map<String, dynamic>;

    final cotacoes = moedas.entries
        .where((entry) => entry.key != 'source')
        .map((entry) => Cotacao.fromJson(entry.value, entry.key))
        .toList();

    final bolsasList = bolsas.entries
        .map((entry) => Bolsa.fromJson(entry.value, entry.key))
        .toList();

    return {
      'cotacoes': cotacoes,
      'bolsas': bolsasList,
    };
  }
}