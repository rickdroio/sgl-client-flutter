import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class MyGrid extends StatelessWidget {
  final List<PlutoColumn> columns;
  final void Function(PlutoGridOnLoadedEvent) onLoadedFunction;
  final Future<PlutoInfinityScrollRowsResponse> Function(
      PlutoInfinityScrollRowsRequest request) fetchFunction;
  final Function(PlutoGridOnChangedEvent)? onChanged;

  final List<PlutoRow> rows = [];

  MyGrid(
      {super.key,
      required this.columns,
      required this.onLoadedFunction,
      required this.fetchFunction,
      this.onChanged});

  final PlutoGridConfiguration configPluto = const PlutoGridConfiguration(
      columnFilter: PlutoGridColumnFilterConfig(),
      localeText: PlutoGridLocaleText.brazilianPortuguese(),
      style: PlutoGridStyleConfig(
          enableGridBorderShadow: false,
          enableColumnBorderVertical: false,
          enableCellBorderVertical: false));

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: onLoadedFunction,
        onChanged: onChanged,
        configuration: configPluto,
        createFooter: (s) => PlutoInfinityScrollRows(
              initialFetch: true,
              fetchWithSorting: true,
              fetchWithFiltering: false,
              fetch: fetchFunction,
              stateManager: s,
            ));
  }
}
