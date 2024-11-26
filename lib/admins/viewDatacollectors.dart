import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'deleteDataCollectors.dart';
import 'updateDataCollectorProfile.dart';
import 'viewEachDatacollector.dart';

class ViewDataCollectors extends StatefulWidget {
  final String? username;
  const ViewDataCollectors({super.key, required this.username});

  @override
  _ViewDataCollectorsState createState() => _ViewDataCollectorsState();
}

class _ViewDataCollectorsState extends State<ViewDataCollectors> {
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

  Future<void> confirmDelete(int id, String username) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ንምስራዝ ኣረጋግፁ'),
          content: const Text('እዚ መረዳእታ ኣካቢ ንኽትስርዝዎ ርግፀኛ ዲኹም? '),
          actions: <Widget>[
            TextButton(
              child: const Text('ኣይኮንኩን'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('እወ'),
              onPressed: () async {
                await deleteDataCollectors(
                  username,
                  widget.username,
                ); // Use the external delete function
                setState(() {
                  data.removeWhere((item) => item['id'] == id);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmUpdate(String username) async {
    BuildContext? currentContext = context;

    return showDialog<void>(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ምምሕያሽ ናይ መረዳእታ ኣካቢ ፕሮፋይል'),
          content: const Text('ናይዚ መረዳእታ ኣካቢ ዝርዝር ሓበሬታ ከመሓይሹ ይደልዩ ዶ? '),
          actions: <Widget>[
            TextButton(
              child: const Text('ኣይደልን'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('እወ'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog first
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateDataCollector(
                          username: username, updatedby: widget.username)),
                );
              },
            ),
          ],
        );
      },
    );
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
                                          ViewEachDataCollector(
                                        id: data[index]['id'],
                                      ),
                                    ),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${index + 1}. ${data[index]['first_name']} ${data[index]['last_name']}',
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Update button
                                await confirmUpdate(data[index]['username']);
                              },
                              child: const Icon(Icons.edit),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Delete button with confirmation
                                await confirmDelete(
                                    data[index]['id'], data[index]['username']);
                              },
                              child: const Icon(Icons.delete,
                                  color:
                                      Colors.red), // Change icon color to red
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
