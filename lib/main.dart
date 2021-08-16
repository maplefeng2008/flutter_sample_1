import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '奥运奖牌榜',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: '奥运奖牌榜'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MedalInfo {
  String country = '';
  int gold = 0;
  int silver = 0;
  int copper = 0;
  int total = 0;

  MedalInfo(country, gold, silver, copper) {
    this.country = country;
    this.gold = gold;
    this.silver = silver;
    this.copper = copper;
    this.total = gold + silver + copper;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _chinaGoldNum = 0;

  int _sortColumnIndex = 2;
  bool _isAscending = false;

  // dummy data
  List<MedalInfo> _medalInfoList = [
    MedalInfo('america', 39, 41, 33),
    MedalInfo('china', 38, 32, 18),
    MedalInfo('japan', 27, 14, 17),
    MedalInfo('england', 22, 21, 22),
  ];

  @override
  void initState() {
    super.initState();

    _chinaGoldNum = 38;
  }

  void _incrementCounter() {
    setState(() {
      // retrive build method
      _chinaGoldNum++;
    });
  }

  List<DataRow> _updateMedalData(double displayWidth) {
    List<DataRow> dataRows = [];
    int _orderGold = 0;

    for (MedalInfo medalInfo in _medalInfoList) {
      dataRows.add(DataRow(cells: [
        DataCell(
          Container(
              width: displayWidth / 6,
              child: Text(
                (++_orderGold).toString(),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              )),
        ),
        DataCell(Container(
            width: displayWidth / 6,
            child: Row(
              children: [
                Expanded(
                  child: Image(
                    image: AssetImage("images/${medalInfo.country}.png"),
                  ),
                ),
                Text(
                  medalInfo.country,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ))),
        DataCell(
          Container(
              width: displayWidth / 6,
              child: Text(
                medalInfo.gold.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.orangeAccent,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        DataCell(
          Container(
              width: displayWidth / 6,
              child: Text(
                medalInfo.silver.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        DataCell(
          Container(
              width: displayWidth / 6,
              child: Text(
                medalInfo.copper.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.amberAccent,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        DataCell(
          Container(
              width: displayWidth / 6,
              child: Text(
                medalInfo.total.toString(),
                textAlign: TextAlign.center,
              )),
        ),
      ]));
    }

    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    double displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: DataTable(
                  sortAscending: _isAscending,
                  sortColumnIndex: _sortColumnIndex,
                  columns: [
                    DataColumn(
                        label: Container(
                      width: displayWidth / 6,
                      child: Text('名次'),
                    )),
                    DataColumn(
                        label: Container(
                      width: displayWidth / 6,
                      child: Text('国家'),
                    )),
                    /*DataColumn(
                        label: Container (
                          child: Text(''),
                        )
                      ),*/
                    DataColumn(
                      label: Container(
                        width: displayWidth / 6,
                        child: Text(
                          '金牌',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.orangeAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      numeric: true,
                      onSort: (int columnIndex, bool asscending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _isAscending = asscending;

                          if (asscending) {
                            _medalInfoList
                                .sort((a, b) => a.gold.compareTo(b.gold));
                          } else {
                            _medalInfoList
                                .sort((a, b) => b.gold.compareTo(a.gold));
                          }
                        });
                      },
                    ),
                    DataColumn(
                      label: Container(
                        width: displayWidth / 6,
                        child: Text(
                          '银牌',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      numeric: true,
                      onSort: (int columnIndex, bool asscending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _isAscending = asscending;

                          if (asscending) {
                            _medalInfoList
                                .sort((a, b) => a.silver.compareTo(b.silver));
                          } else {
                            _medalInfoList
                                .sort((a, b) => b.silver.compareTo(a.silver));
                          }
                        });
                      },
                    ),
                    DataColumn(
                      label: Container(
                        width: displayWidth / 6,
                        child: Text(
                          '铜牌',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.amberAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      numeric: true,
                      onSort: (int columnIndex, bool asscending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _isAscending = asscending;

                          if (asscending) {
                            _medalInfoList
                                .sort((a, b) => a.copper.compareTo(b.copper));
                          } else {
                            _medalInfoList
                                .sort((a, b) => b.copper.compareTo(a.copper));
                          }
                        });
                      },
                    ),
                    DataColumn(
                      label: Container(
                        width: displayWidth / 6,
                        child: Text(
                          '总数',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      numeric: true,
                      onSort: (int columnIndex, bool asscending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _isAscending = asscending;

                          if (asscending) {
                            _medalInfoList
                                .sort((a, b) => a.total.compareTo(b.total));
                          } else {
                            _medalInfoList
                                .sort((a, b) => b.total.compareTo(a.total));
                          }
                        });
                      },
                    ),
                  ],
                  rows: _updateMedalData(displayWidth),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '刷新',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
