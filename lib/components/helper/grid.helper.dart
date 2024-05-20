import 'dart:convert';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:sgl_app_flutter/models/base.model.dart';

class GridHelper {
  static List<PlutoRow> modelToPlutoRows(List<BaseModel> items) {
    List<PlutoRow> rows = [];

    for (var item in items) {
      //print('modelToPlutoRows >> ${item.toJson()}');
      rows.add(PlutoRow.fromJson(item.toJson()));
    }

    return rows;
  }

  static List<T> plutoRowsToModel<T>(
      List<PlutoRow> rows, T Function(Map<String, dynamic>) fFromJson,
      {bool isUpdated = true}) {
    List<T> items = [];

    for (var row in rows) {
      if ((isUpdated && row.state.isUpdated) || !isUpdated) {
        items.add(fFromJson(row.toJson()));
      }
    }

    return items;
  }

  static String plutoRowsToJson(List<PlutoRow> rows) {
    var filterRows = rows.where((row) => row.state.isUpdated);
    return jsonEncode(filterRows.map((row) => row.toJson()).toList());
  }
}
