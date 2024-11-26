import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'deleteAdmins.dart';
import 'updateAdminProfile.dart';
import 'viewEachDataAdmin.dart';

class ViewAdmins extends StatefulWidget {
  const ViewAdmins({super.key});

  @override
  __ViewAdminsState createState() => __ViewAdminsState();
}

class __ViewAdminsState extends State<ViewAdmins> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/GetAdmins'));

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
          content: const Text('እዚ ኣድሚን ንኽትስርዝዎ ርግፀኛ ዲኹም? '),
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
                await deleteAdmins(id); // Use the external delete function
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
          content: const Text('ናይዚ ኣድሚን ዝርዝር ሓበሬታ ከመሓይሹ ይደልዩ ዶ? '),
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
                      builder: (context) =>
                          Updateadminprofile(id: id.toString())),
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
        title: const Text('ዝርዝር ኣድሚናት'),
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
                        // Align the content inside the cell
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Make sure children start from the left
                          children: [
                            Expanded(
                              // Use Align to set text alignment to left
                              child: Align(
                                alignment: Alignment
                                    .centerLeft, // Align content to the left
                                child: TextButton(
                                  onPressed: () {
                                    // Navigate to detail page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewEachAdmin(
                                          id: data[index]['id'],
                                        ),
                                      ),
                                    );
                                  },
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
                                await confirmUpdate(data[index]['id']);
                              },
                              child: const Icon(Icons.edit),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Delete button with confirmation
                                await confirmDelete(data[index]['id']);
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
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: Text(
          'ድምር ኣድሚናት:- ${data.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
