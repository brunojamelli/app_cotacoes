import 'package:flutter/material.dart';

class VariacaoUtils {
  static Map<String, dynamic> getVariacaoStyle(double? variacao) {
    if (variacao == null) {
      return {
        'color': Colors.grey, 
        'symbol': '',
      };
    }

    if (variacao >= 0) {
      return {
        'color': Colors.green, 
        'symbol': '+',
      };
    } else {
      return {
        'color': Colors.red, 
        'symbol': '',
      };
    }
  }
}