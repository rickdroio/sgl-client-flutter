import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_it/get_it.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sgl_app_flutter/components/grid.dart';
import 'package:sgl_app_flutter/components/helper/grid.helper.dart';
import 'package:sgl_app_flutter/services/cores.service.dart';

class CorPageOld extends StatefulWidget {
  const CorPageOld({super.key});

  @override
  State<CorPageOld> createState() => _CorPageState();
}

class _CorPageState extends State<CorPageOld> {
  final _key = GlobalKey<ExpandableFabState>();
  final cidadesService = GetIt.I.get<CoresService>();
  late final PlutoGridStateManager stateManager;

  TextEditingController searchController = TextEditingController();

  //List<PlutoRow> rows = [];

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
        title: 'ID', field: 'id', type: PlutoColumnType.number(), hide: true),
    PlutoColumn(
      title: 'Nome',
      field: 'nome',
      type: PlutoColumnType.text(),
    ),
/*     PlutoColumn(
        title: 'Sigla',
        field: 'sigla',
        formatter: (value) => (value.toString().length <= 2)
            ? value.toString()
            : value.toString().substring(0, 2),
        applyFormatterInEditing: true,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center), */

    PlutoColumn(
      title: 'Sigla',
      field: 'sigla',
      type: PlutoColumnType.text(),
      /*        renderer: (rendererContext) {
          return Text(rendererContext.cell.value.toString(),
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ));
        } */
    )
  ];

  var configPluto = const PlutoGridConfiguration(
      columnFilter: PlutoGridColumnFilterConfig(),
      localeText: PlutoGridLocaleText.brazilianPortuguese(),
      style: PlutoGridStyleConfig(
          enableGridBorderShadow: false,
          enableColumnBorderVertical: false,
          enableCellBorderVertical: false));

/*   @override
  void initState() {
    super.initState();
    cidadesService.getAll().then((items) {
      //var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      //print(response);

      setState(() {
/*         List<Cidade> items =
            (response as List).map((item) => Cidade.fromJson(item)).toList(); */

        rows = GridHelper.modelToPlutoRows(items);

        loading = false;
      });
    });
  } */

  Future<PlutoInfinityScrollRowsResponse> fetch(
      PlutoInfinityScrollRowsRequest request) async {
    var cidades = await cidadesService.getAll(offset: stateManager.rows.length);
    var newrows = GridHelper.modelToPlutoRows(cidades);

    return Future.value(PlutoInfinityScrollRowsResponse(
      isLast: newrows.isEmpty,
      rows: newrows,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CIDADES'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
            key: _key,
            type: ExpandableFabType.up,
            distance: 80,
            children: [
              FloatingActionButton.small(
                child: const Icon(Icons.save),
                onPressed: () {
                  cidadesService.updateBatch(
                      GridHelper.plutoRowsToJson(stateManager.rows));
                },
              ),
              FloatingActionButton.small(
                child: const Icon(Icons.add),
                onPressed: () {
                  stateManager.prependNewRows();
                },
              ),
            ]),
        body: Column(
          children: [
/*             SizedBox(
              height: 80,
              //width: 200,
              child: EditText(
                controller: searchController,
                label: 'Procurar',
                fieldType: EditTextType.text,
                onSubmitted: (String value) {
                  cidadesService.getAllFiltered(value).then((items) {
                    setState(() {
                      //stateManager.
                      
                      print(items);
                      rows = GridHelper.modelToPlutoRows(items);
                    });
                  });
                },
              ),
            ), */
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: MyGrid(
                      columns: columns,
                      onLoadedFunction: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                        //stateManager.setShowColumnFilter(true);
                      },
                      fetchFunction: fetch)),
            ),
            /* Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: PlutoGrid(
                      columns: columns,
                      rows: rows,
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                        //stateManager.setShowColumnFilter(true);
                      },
                      onChanged: (PlutoGridOnChangedEvent event) {
                        //print(event);
                        if (event.column.field == 'sigla') {
                          stateManager.changeCellValue(
                              event.row.cells['sigla']!,
                              event.value.toString().length <= 2
                                  ? event.value.toString().toUpperCase()
                                  : event.value
                                      .toString()
                                      .toUpperCase()
                                      .substring(0, 2));
                        }
                      },
                      configuration: configPluto,
                      createFooter: (s) => PlutoInfinityScrollRows(
                            initialFetch: true,
                            fetchWithSorting: true,
                            fetchWithFiltering: false,
                            fetch: fetch,
                            stateManager: s,
                          ))),
            ), */
/*             SizedBox(
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: MyButton(caption: 'Salvar', onPressed: () {})),
                    Expanded(
                        flex: 1,
                        child: MyButton(caption: 'Cancelar', onPressed: () {})),
                  ],
                )) */
          ],
        ));
  }
}
