import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../data collectors/viewEachNonMovabledata.dart';
import 'MessageToDataCollectorNonMov.dart';
import 'MessageFromDataCollectorNonMov.dart';

class ViewEachDataCollectorDatas extends StatefulWidget {
  final String? username;

  const ViewEachDataCollectorDatas({super.key, required this.username});

  @override
  _ViewEachDataCollectorState createState() => _ViewEachDataCollectorState();
}

class _ViewEachDataCollectorState extends State<ViewEachDataCollectorDatas> {
  List<Map<String, dynamic>> _data = [];
  Map<String, dynamic> _confirmedData = {};

  @override
  void initState() {
    super.initState();
    loadConfirmedData();
    fetchData();
  }

  Future<void> loadConfirmedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final confirmedDataJson = prefs.getString('confirmed_data');
      if (confirmedDataJson != null) {
        _confirmedData = jsonDecode(confirmedDataJson);
      }
    } catch (e) {
      print('Error loading confirmed data: $e');
    }
  }

  Future<void> saveConfirmedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('confirmed_data', jsonEncode(_confirmedData));
    } catch (e) {
      print('Error saving confirmed data: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/gettingNonMovableData?username=${widget.username}'));
      if (response.statusCode == 200) {
        String responseBody = response.body;
        List<Map<String, dynamic>> dataJson =
            List<Map<String, dynamic>>.from(jsonDecode(responseBody));
        List<Map<String, dynamic>> newData = [];
        for (int i = 0; i < dataJson.length; i++) {
          http.Response confirmedResponse = await http.get(Uri.parse(
              'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/confirmed?id=${dataJson[i]['id']}'));
          if (confirmedResponse.statusCode == 200) {
            Map<String, dynamic> confirmedData =
                jsonDecode(utf8.decode(confirmedResponse.bodyBytes));
            dataJson[i]['confirmed'] = confirmedData['confirmed'];
          }
          newData.add(dataJson[i]);
        }
        setState(() {
          _data = newData;
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<bool> confirm(int id) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/confirm'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'id': id.toString()}));
      if (response.statusCode == 200) {
        setState(() {
          _confirmedData[id.toString()] = true;
        });
        saveConfirmedData();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error confirming data: $e');
      return false;
    }
  }

  String confirmedText(Map<String, dynamic> data) {
    if (_confirmedData.containsKey(data['id'].toString()) &&
        _confirmedData[data['id'].toString()] == true) {
      return 'ተረጋጊፁ';
    } else {
      return 'ኣይተረጋገፀን';
    }
  }

  Color confirmedColor(Map<String, dynamic> data) {
    if (_confirmedData.containsKey(data['id'].toString()) &&
        _confirmedData[data['id'].toString()] == true) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ዘይንቐሳቐሱ ሓድግታት'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(color: Colors.grey, width: 1),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Start alignment for children
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment
                                    .centerLeft, // Align TextButton to the left
                                child: TextButton(
                                  onPressed: () async {
                                    // Navigate to detail page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ViewNonMovableDataDetail(
                                                id: _data[index]['id']),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '${index + 1}. ${_data[index]['heritage_name']}',
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Navigate to report page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chattingMessage(
                                          id: _data[index]['id'])),
                                );
                              },
                              child: const Icon(Icons.send),
                            ),
                            TextButton(
                              onPressed: () async {
                                final id = _data[index]['id'];
                                // Send request to backend to update seen_data_collector and seen_datacollector_message
                                final response = await http.put(
                                  Uri.parse(
                                      'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/update-seen-data-collector-non-mov/$id'),
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
                                          MessageFromDataCollector(id: id),
                                    ),
                                  );
                                } else {
                                  print('Error updating seen_data_collector');
                                }
                              },
                              child: (_data[index]
                                          ['seen_datacollector_message'] ==
                                      0)
                                  ? const Icon(
                                      Icons.chat_bubble_outline_rounded)
                                  : const Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      color: Colors.red),
                            ),
                            TextButton(
                              onPressed: () async {
                                bool confirmed =
                                    await confirm(_data[index]['id']);
                                if (confirmed) {}
                              },
                              child: Text(
                                confirmedText(_data[index]),
                                style: TextStyle(
                                    color: confirmedColor(_data[index])),
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
