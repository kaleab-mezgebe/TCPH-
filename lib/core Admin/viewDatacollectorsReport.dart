import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'viewEachDatacollector.dart';
import 'report.dart';

class Viewdatacollectorsreport extends StatefulWidget {
  const Viewdatacollectorsreport({super.key});

  @override
  _ViewdatacollectorsreportState createState() =>
      _ViewdatacollectorsreportState();
}

class _ViewdatacollectorsreportState extends State<Viewdatacollectorsreport> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/reportt'));
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
        title: const Text('ዝርዝር መረዳእታ ኣከብቲ'),
        backgroundColor: Colors.blue, // Set the background color to blue
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(
                color: Colors.grey,
                width: 1,
              ),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}.',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                // Navigate to detail page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewEachDataCollector(
                                      username: data[index]['datacollector'],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                '${' '}  ${data[index]['first_name']}  ${data[index]['last_name']}',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextButton(
                        onPressed: () async {
                          // Navigate to report page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewReportDataCollector(
                                username: data[index]['datacollector'],
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.library_books),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: Text(
          'ድምር መረዳእታ ኣከብቲ:- ${data.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
