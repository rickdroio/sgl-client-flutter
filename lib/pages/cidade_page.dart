import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_it/get_it.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sgl_app_flutter/components/helper/grid.helper.dart';
import 'package:sgl_app_flutter/models/cidade.dart';
import 'package:sgl_app_flutter/services/cidades.service.dart';

class CidadePage extends StatefulWidget {
  const CidadePage({super.key});

  @override
  State<CidadePage> createState() => _CidadePageState();
}

class _CidadePageState extends State<CidadePage> {
  final _key = GlobalKey<ExpandableFabState>();
  final cidadesService = GetIt.I.get<CidadesService>();
  late final PlutoGridStateManager stateManager;

  TextEditingController searchController = TextEditingController();

  List<PlutoRow> rows = [];

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
        title: 'ID', field: 'id', type: PlutoColumnType.number(), hide: true),
    PlutoColumn(
      title: 'Nome',
      field: 'nome',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
        title: 'UF',
        field: 'uf',
        type: PlutoColumnType.select(Cidade.ufList),
        textAlign: PlutoColumnTextAlign.center),
    PlutoColumn(
      title: 'IBGE',
      field: 'ibge',
      type: PlutoColumnType.text(),
    ),
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
    var cidades = await cidadesService.getAll(offset: rows.length);
    var newrows = GridHelper.modelToPlutoRows(cidades);

    //if (request.lastRow != null) print(request.lastRow.);

/*     Iterable<PlutoRow> fetchedRows = tempList.skipWhile(
      (row) => request.lastRow != null && row.key != request.lastRow!.key,
    );
    if (request.lastRow == null) {
      fetchedRows = fetchedRows.take(30);
    } else {
      fetchedRows = fetchedRows.skip(1).take(30);
    } */

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
                  cidadesService.updateBatch(GridHelper.plutoRowsToJson(rows));
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
                  child: PlutoGrid(
                      columns: columns,
                      rows: rows,
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                        //stateManager.setShowColumnFilter(true);
                      },
                      onChanged: (PlutoGridOnChangedEvent event) {
                        print(event);
                      },
                      configuration: configPluto,
                      createFooter: (s) => PlutoInfinityScrollRows(
                            initialFetch: true,
                            fetchWithSorting: true,
                            fetchWithFiltering: false,
                            fetch: fetch,
                            stateManager: s,
                          ))),
            ),
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
