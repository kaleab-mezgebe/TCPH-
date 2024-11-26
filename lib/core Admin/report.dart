import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewReportDataCollector extends StatefulWidget {
  final String? username;

  const ViewReportDataCollector({super.key, required this.username});

  @override
  _ViewReportDataCollectorState createState() =>
      _ViewReportDataCollectorState();
}

class _ViewReportDataCollectorState extends State<ViewReportDataCollector> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      print('Fetching data for ID: ${widget.username}'); // Debug print
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/report?username=${widget.username}'));

      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ፀብፃብ ስለ መረዳእታ ኣካቢ'),
        backgroundColor: Colors.blue, // Set the background color to blue
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final row = data[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(
                color: Colors.grey,
                width: 1,
              ),
              columnWidths: const {
                0: FlexColumnWidth(0.3),
                1: FlexColumnWidth(0.7),
              },
              children: row.entries.map((entry) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(entry.key),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(entry.value.toString()),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
