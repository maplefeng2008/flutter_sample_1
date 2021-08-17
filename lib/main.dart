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
  int _columnNum = 6 * 2;

  int _sortColumnIndex = 2;
  bool _isAscending = false;

  // dummy data
  List<MedalInfo> _medalInfoList = [
    MedalInfo('america', 39, 41, 33),
    MedalInfo('china', 38, 32, 18),
    MedalInfo('japan', 27, 14, 17),
    MedalInfo('england', 22, 21, 22),
  ];

  void _incrementCounter() {
    setState(() {
      // retrive build method
      int i = 0;
      do {
        if (_medalInfoList[i].country == 'china') {
          _medalInfoList[i].gold++;
        }
      } while (++i < _medalInfoList.length);
    });
  }

  List<DataRow> _updateMedalData(double displayWidth) {
    List<DataRow> dataRows = [];
    int _order = 0;

    if (_isAscending) {
      _medalInfoList.sort((a, b) => a.gold.compareTo(b.gold));
    } else {
      _medalInfoList.sort((a, b) => b.gold.compareTo(a.gold));
    }

    for (MedalInfo medalInfo in _medalInfoList) {
      dataRows.add(DataRow(cells: [
        DataCell(
          Container(
              width: displayWidth / _columnNum,
              child: Text(
                (++_order).toString(),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              )),
        ),
        DataCell(
          Container(
            width: displayWidth / _columnNum,
            child: Image(
              image: AssetImage("images/${medalInfo.country}.png"),
              width: displayWidth / _columnNum,
            ),
          ),
        ),
        DataCell(
          Container(
              width: displayWidth / _columnNum,
              child: Text(
                medalInfo.gold.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.orangeAccent,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        DataCell(
          Container(
              width: displayWidth / _columnNum,
              child: Text(
                medalInfo.silver.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        DataCell(
          Container(
              width: displayWidth / _columnNum,
              child: Text(
                medalInfo.copper.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.amberAccent,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        DataCell(
          Container(
              width: displayWidth / _columnNum,
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
                      width: displayWidth / _columnNum,
                      child: Text('名次'),
                    )),
                    DataColumn(
                        label: Container(
                      width: displayWidth / _columnNum,
                      child: Text('国家'),
                    )),
                    DataColumn(
                      label: Container(
                        width: displayWidth / _columnNum,
                        child: Text(
                          '金牌',
                          style: TextStyle(
                            fontSize: 15,
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
                        width: displayWidth / _columnNum,
                        child: Text(
                          '银牌',
                          style: TextStyle(
                            fontSize: 15,
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
                        width: displayWidth / _columnNum,
                        child: Text(
                          '铜牌',
                          style: TextStyle(
                            fontSize: 15,
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
                        width: displayWidth / _columnNum,
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
            Container(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: Text("提示"),
                        content: Text("待完善."),
                        actions: [
                          new TextButton(
                              child: new Text('确定'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    },
                  );
                },
                child: Text('显示更多'),
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 18, color: Colors.black)))),
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
