import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Convert.dart';
import 'Result.dart';
import 'input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
// This widget is the root of your application.
  double _inputUser = 0;
  double _kelvin = 0;
  double _reamur = 0;
  final inputController = TextEditingController();
  String _newValue = "Kelvin";
  double _result = 0;
  List<String> listViewItem = List<String>();
  void perhitunganSuhu() {
    setState(() {
      _inputUser = double.parse(inputController.text);
      if (_newValue == "Kelvin")
        _result = _inputUser + 273;
      else
        _result = (4 / 5) * _inputUser;
      listViewItem.add("$_newValue : $_result");
    });
  }

  var listItem = ["Kelvin", "Reamur"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Konverter Suhu"),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              input(inputController: inputController),
              DropdownButton<String>(
                items: listItem.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _newValue,
                onChanged: (String changeValue) {
                  setState(() {
                    _newValue = changeValue;
                    perhitunganSuhu();
                  });
                },
              ),
              Result(result: _result),
              Convert(convertHandler: perhitunganSuhu),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Riwayat Konversi",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView(
                    children: listViewItem.map((String value) {
                  return Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      ));
                }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
