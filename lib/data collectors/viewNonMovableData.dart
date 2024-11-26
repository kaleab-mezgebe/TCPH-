import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'deleteNonMovableData.dart';
import 'viewEachNonMovabledata.dart';
import 'updateNonMovableData.dart';
import 'MessageToAdminNonMov.dart';

class ViewNonMovableData extends StatefulWidget {
  final String? username;
  const ViewNonMovableData({super.key, required this.username});

  @override
  _NonMovableDataPageState createState() => _NonMovableDataPageState();
}

class _NonMovableDataPageState extends State<ViewNonMovableData> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/gettingNonMovableData?username=${widget.username}'));
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

  Future<void> confirmDelete(int id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ንምስራዝ ኣረጋግፁ'),
          content: const Text('እዚ ዘይንቐሳቐስ ሓድጊ ንኽትስርዝዎ ርግፀኛ ዲኹም? '),
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
                await deleteNonMovableData(
                    id); // Use the external delete function
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

  Future<void> confirmUpdate(int id) async {
    BuildContext? currentContext = context;

    return showDialog<void>(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ምምሕያሽ ናይ ኣድሚን ፕሮፋይል'),
          content: const Text('ናይዚ ዘይንቐሳቐስ ሓድጊ ዝርዝር ሓበሬታ ከመሓይሹ ይደልዩ ዶ? '),
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
                      builder: (context) => UpdateNonmovabledata(id: id)),
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
        title: const Text('ዘይንቐሳቐሱ ሓድግታት'),
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
                              child: Align(
                                alignment: Alignment
                                    .centerLeft, // Align text to the left
                                child: TextButton(
                                  onPressed: () {
                                    // Navigate to detail page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ViewNonMovableDataDetail(
                                          id: data[index]['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '${index + 1}. ${data[index]['heritage_name']}',
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final id = data[index]['id'];

                                // Send request to backend to update seen_data_collector and seen_datacollector_message
                                final response = await http.put(
                                  Uri.parse(
                                      'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/update-seen-admin_message-non-mov/$id'),
                                  headers: {
                                    'Content-Type': 'application/json',
                                  },
                                );

                                if (response.statusCode == 200) {
                                  // Navigate to MessageFromDataCollector page with id
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          chattingMessage(id: id),
                                    ),
                                  );
                                } else {
                                  print('Error updating seen_data_collector');
                                }
                              },
                              child: (data[index]['seen_adimin_message'] == 0)
                                  ? const Icon(
                                      Icons.chat_bubble_outline_rounded)
                                  : const Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      color: Colors.red,
                                    ),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Update button
                                await confirmUpdate(data[index]['id']);
                              },
                              child: const Icon(Icons.edit),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Delete button with confirmation
                                await confirmDelete(data[index]['id']);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ), // Change icon color to red
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
