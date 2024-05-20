import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sgl_app_flutter/components/grid.dart';

abstract class BaseEditListPage extends StatefulWidget {
  const BaseEditListPage({super.key});
}

abstract class BaseEditListPageState<Page extends BaseEditListPage>
    extends State<Page> {
  final _key = GlobalKey<ExpandableFabState>();
  late final PlutoGridStateManager stateManager;

  late List<PlutoColumn> columns = <PlutoColumn>[];

  String appBarTitle();
  void saveOnPressed();
  void insertOnPressed();
  List<PlutoColumn> setColumns();
  Future<PlutoInfinityScrollRowsResponse> fetchData(
      PlutoInfinityScrollRowsRequest request);
  void onGridChanged(PlutoGridOnChangedEvent event);

  @override
  void initState() {
    super.initState();
    columns = setColumns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle()),
        centerTitle: true,
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
          key: _key,
          type: ExpandableFabType.up,
          distance: 80,
          children: [
            FloatingActionButton.small(
              onPressed: saveOnPressed,
              child: const Icon(Icons.save),
            ),
            FloatingActionButton.small(
              onPressed: insertOnPressed,
              child: const Icon(Icons.add),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(5),
                child: MyGrid(
                  columns: columns,
                  onLoadedFunction: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                  },
                  fetchFunction: fetchData,
                  onChanged: onGridChanged,
                )),
          ),
        ],
      ),
    );
  }
}
