import 'dart:convert';
import 'package:sgl_app_flutter/models/base.model.dart';

class JsonHelper {
  static String modelToJson<T>(List<T> items) {
    return jsonEncode(items.map((e) => (T as BaseModel).toJson()).toList());
  }
}
