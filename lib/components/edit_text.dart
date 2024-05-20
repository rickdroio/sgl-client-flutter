import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgl_app_flutter/components/helper/format.helper.dart';

enum EditTextType { text, email, password, number, double, percentual, date }

class EditText extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final bool obscureText;
  final bool readonly;
  final EditTextType fieldType;
  final void Function(String value)? searchcallback;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final IconData? prefixIcon;
  final IconData searchIcon;
  final List<TextInputFormatter>? textFormater;
  final bool digitsOnly; //usando no formater
  final FocusNode? focusNode;
  final bool validator;
  final bool autofocus;

  const EditText(
      {super.key,
      required this.controller,
      required this.label,
      this.hint = '',
      required this.fieldType,
      this.obscureText = false,
      this.readonly = false,
      this.prefixIcon,
      this.searchcallback,
      this.onSubmitted,
      this.onChanged,
      this.textFormater,
      this.digitsOnly = false,
      this.searchIcon = Icons.search,
      this.focusNode,
      this.validator = true,
      this.autofocus = false});

  isValidText(String value) {
    if (value.trim() == '') {
      return 'Campo inválido';
    }
  }

  isEmail(String value) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value)) {
      return 'Campo inválido';
    }
  }

  isAtPercentualRange(String value) {
    var valor = double.tryParse(value) ?? 0;
    if (!(valor >= 0 && valor <= 100)) {
      return 'Valor percentual inválido';
    }
  }

  isDate(String value) {
    final dateRegExp = RegExp(
        r"(0[1-9]|[12][0-9]|3[01])(\/|-)(0[1-9]|1[1,2])(\/|-)(19|20)\d{2}");
    if (!dateRegExp.hasMatch(value)) {
      return 'Data inválido';
    }
  }

/*   checkRegexValidation(String regex, String value) {
    final r = RegExp(regex);
    if (!r.hasMatch(value)) {
      return 'Campo inválido';
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        readOnly: readonly,
        decoration: InputDecoration(
          fillColor: (readonly) ? Colors.grey.shade200 : null,
          filled: (readonly),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.grey, width: 1)),

          hintText: hint,
          labelText: label,
          //icon: Icon(Icons.add_box),
          prefixIcon: (prefixIcon != null) ? Icon(prefixIcon) : null,
          suffixIcon: searchcallback != null
              ? IconButton(
                  onPressed: () => searchcallback!(controller.text),
                  icon: Icon(searchIcon))
              : null,
        ),
        inputFormatters: [
          if (fieldType == EditTextType.number ||
              fieldType == EditTextType.date ||
              digitsOnly)
            FilteringTextInputFormatter.digitsOnly,
          if (fieldType == EditTextType.double ||
              fieldType == EditTextType.percentual)
            FormatHelper.digitsDecimalOnly,
          if (fieldType == EditTextType.date) DataInputFormatter(),
          //if (maxRange != null && minRange != null) NumericRangeFormatter(min: minRange ?? 0, max: maxRange ?? 0),
          if (textFormater != null) ...?textFormater,
        ],
        validator: validator
            ? (value) {
                var valorCampo = (value != null) ? value : '';

                if (fieldType == EditTextType.text ||
                    fieldType == EditTextType.password) {
                  return isValidText(valorCampo);
                } else if (fieldType == EditTextType.email) {
                  return isEmail(valorCampo);
                } else if (fieldType == EditTextType.percentual) {
                  return isAtPercentualRange(valorCampo);
                } else if (fieldType == EditTextType.date &&
                    valorCampo.length >= 8) {
                  return isDate(valorCampo);
                }

                return null;
              }
            : null,
        onFieldSubmitted: onSubmitted,
        onChanged: onChanged,
      ),
    );
  }
}
