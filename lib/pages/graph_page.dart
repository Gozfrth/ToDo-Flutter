import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';

class GraphPage extends StatefulWidget {
  final List filteredList;

  GraphPage({super.key, required this.filteredList});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<DateTime> highData = [];
  List<DateTime> mediumData = [];
  List<DateTime> lowData = [];

  List<double> highCount = List<double>.filled(7, 0);
  List<double> mediumCount = List<double>.filled(7, 0);
  List<double> lowCount = List<double>.filled(7, 0);

  DateTime now = DateTime.now();

  @override
  void initState() {
    highData = widget.filteredList
        .where((element) => element[1] == true && element[4] == 'high')
        .map((element) => DateTime.parse(element[5].toString()))
        .toList();

    mediumData = widget.filteredList
        .where((element) => element[1] == true && element[4] == 'medium')
        .map((element) => DateTime.parse(element[5].toString()))
        .toList();

    lowData = widget.filteredList
        .where((element) => element[1] == true && element[4] == 'low')
        .map((element) => DateTime.parse(element[5].toString()))
        .toList();

    for (DateTime v in highData) {
      var diff = now.difference(v).inDays;
      if (diff < 7) {
        highCount[diff] += 0.2;
      }
    }
    for (DateTime v in mediumData) {
      var diff = now.difference(v).inDays;
      if (diff < 7) {
        mediumCount[diff] += 0.2;
      }
    }
    for (DateTime v in lowData) {
      var diff = now.difference(v).inDays;
      if (diff < 7) {
        lowCount[diff] += 0.2;
      }
    }

    print('$lowData');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Feature> features = [
      Feature(
        title: "High",
        color: Color(0xffdd7777),
        data: highCount,
      ),
      Feature(
        title: "Medium",
        color: Color(0xff7777dd),
        data: mediumCount,
      ),
      Feature(
        title: "Low",
        color: Color(0xff77dd77),
        data: lowCount,
      ),
    ];
    return Scaffold(
        backgroundColor: const Color(0xff272727),
        appBar: AppBar(
          backgroundColor: const Color(0xff353535),
          title: const Text(
            "Graph Viewer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: LineGraph(
            features: features,
            size: const Size(320, 400),
            labelX: const [
              'Day 1',
              'Day 2',
              'Day 3',
              'Day 4',
              'Day 5',
              'Day 6',
              'Day 7'
            ],
            labelY: const ['1', '2', '3', '4', '5'],
            showDescription: true,
            graphColor: Colors.white30,
            graphOpacity: 0.8,
            verticalFeatureDirection: true,
            descriptionHeight: 130,
          ),
        ));
  }
}
