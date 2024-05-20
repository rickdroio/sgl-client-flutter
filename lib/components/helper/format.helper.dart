import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class FormatHelper {
  static final TextInputFormatter digitsDecimalOnly =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\,?\d{0,2}'));

  static formatCPF(String value) {
    final regex = RegExp(r'(\d{3})(\d{3})(\d{3})(\d{2})');
    final matches = regex.allMatches(value);
    if (matches.isNotEmpty) {
      final match = matches.first;
      return '${match.group(1)}.${match.group(2)}.${match.group(3)}-${match.group(4)}';
    }
  }

  static formatPesoGramas(String value) {
    return '$value g';
  }

  static formatBRL(String value, {bool moeda = true}) {
    var valorDouble = double.tryParse(value);
    var valorFormatado =
        UtilBrasilFields.obterReal(valorDouble ?? 0, moeda: moeda);

    //print('formatBRL $value $valorDouble - $valorFormatado');

    return valorFormatado;
  }

  static formatBRLToString(double value, {bool moeda = true}) {
    var valorFormatado = UtilBrasilFields.obterReal(value, moeda: moeda);

    //print('formatBRL $value $valorDouble - $valorFormatado');

    return valorFormatado;
  }

  static double stringToDouble(String value) {
    var valor = value.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(valor) ?? 0;
  }
}
