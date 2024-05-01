import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ChartData>? chartData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const url = 'https://disease.sh/v3/covid-19/historical/all?lastdays=all';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final Map<String, dynamic> timelineData = data['cases'];

      chartData = timelineData.entries.map((entry) {
        return ChartData(entry.key, entry.value);
      }).toList();

      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid-19 Historical Data'),
      ),
      body: chartData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  series: <CartesianSeries<dynamic, String>>[
                    LineSeries<ChartData, String>(
                      dataSource: chartData!,
                      xValueMapper: (ChartData data, _) => data.date,
                      yValueMapper: (ChartData data, _) => data.count,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ChartData {
  final String date;
  late dynamic count;

  ChartData(this.date, this.count);
}
