class Bolsa {
  final String codigo;
  final String nome;
  final String localizacao;
  final double? pontos;
  final double? variacao;

  Bolsa({
    required this.codigo,
    required this.nome,
    required this.localizacao,
    this.pontos,
    this.variacao,
  });

  factory Bolsa.fromJson(Map<String, dynamic> json, String codigo) {
    return Bolsa(
      codigo: codigo,
      nome: json['name'],
      localizacao: json['location'],
      pontos: json['points'],
      variacao: json['variation'],
    );
  }
}