import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'viewMovableData.dart';

class ViewDataCollectorsFullNameMov extends StatefulWidget {
  final String? username;
  const ViewDataCollectorsFullNameMov({super.key, required this.username});

  @override
  _ViewDataCollectorsFullNameStateMov createState() =>
      _ViewDataCollectorsFullNameStateMov();
}

class _ViewDataCollectorsFullNameStateMov
    extends State<ViewDataCollectorsFullNameMov> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/GetDatacollector?username=${widget.username}'));
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
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  // Navigate to detail page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewEachDataCollectorDatas(
                                        username: data[index]['username'],
                                      ),
                                    ),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment
                                      .centerLeft, // Align text to the left
                                  child: Text(
                                    '${index + 1}. ${data[index]['first_name']} ${data[index]['last_name']}',
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
