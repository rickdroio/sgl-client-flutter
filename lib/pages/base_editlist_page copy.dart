import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sgl_app_flutter/components/grid.dart';

class BaseEditListPage extends StatefulWidget {
  const BaseEditListPage({super.key, required this.title});

  final String title;

  @override
  State<BaseEditListPage> createState() => BaseEditListPageState();
}

class BaseEditListPageState<T extends BaseEditListPage> extends State<T> {
  final _key = GlobalKey<ExpandableFabState>();
  late final PlutoGridStateManager stateManager;

  final List<PlutoColumn> columns = <PlutoColumn>[];

  void saveOnPressed() {}
  void insertOnPressed() {}
  //Future<PlutoInfinityScrollRowsResponse> fetchData(PlutoInfinityScrollRowsRequest request) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      /*  body: Column(
        children: [
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(5),
                child: MyGrid(
                    columns: columns,
                    onLoadedFunction: (PlutoGridOnLoadedEvent event) {
                      stateManager = event.stateManager;
                      //stateManager.setShowColumnFilter(true);
                    },
                    fetchFunction: fetchData)),
          ),
        ],
      ), */
    );
  }
}
