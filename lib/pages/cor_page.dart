import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sgl_app_flutter/components/helper/grid.helper.dart';
import 'package:sgl_app_flutter/pages/base_editlist_page.dart';
import 'package:sgl_app_flutter/services/cores.service.dart';

class CorPage extends BaseEditListPage {
  const CorPage({super.key});

  @override
  State<CorPage> createState() => _CorPageState();
}

class _CorPageState extends BaseEditListPageState<CorPage> {
  final cidadesService = GetIt.I.get<CoresService>();

  @override
  String appBarTitle() {
    return 'CORES';
  }

  @override
  List<PlutoColumn> setColumns() {
    return <PlutoColumn>[
      PlutoColumn(
          title: 'ID', field: 'id', type: PlutoColumnType.number(), hide: true),
      PlutoColumn(
        title: 'Nome',
        field: 'nome',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Sigla',
        field: 'sigla',
        type: PlutoColumnType.text(),
      )
    ];
  }

  @override
  Future<PlutoInfinityScrollRowsResponse> fetchData(
      PlutoInfinityScrollRowsRequest request) async {
    var cidades = await cidadesService.getAll(offset: stateManager.rows.length);
    var newrows = GridHelper.modelToPlutoRows(cidades);

    return Future.value(PlutoInfinityScrollRowsResponse(
      isLast: newrows.isEmpty,
      rows: newrows,
    ));
  }

  @override
  void insertOnPressed() {
    stateManager.prependNewRows();
  }

  @override
  void saveOnPressed() {
    cidadesService.updateBatch(GridHelper.plutoRowsToJson(stateManager.rows));
  }

  @override
  void onGridChanged(PlutoGridOnChangedEvent event) {
    if (event.column.field == 'sigla') {
      stateManager.changeCellValue(
          event.row.cells['sigla']!,
          event.value.toString().length <= 2
              ? event.value.toString().toUpperCase()
              : event.value.toString().toUpperCase().substring(0, 2));
    }
  }
}
