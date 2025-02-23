class Cotacao {
  final String codigo;
  final String nome;
  final double? compra;
  final double? venda;
  final double? variacao;

  Cotacao({
    required this.codigo,
    required this.nome,
    this.compra,
    this.venda,
    this.variacao,
  });

  factory Cotacao.fromJson(Map<String, dynamic> json, String codigo) {
    return Cotacao(
      codigo: codigo,
      nome: json['name'],
      compra: json['buy'],
      venda: json['sell'],
      variacao: json['variation'],
    );
  }
}