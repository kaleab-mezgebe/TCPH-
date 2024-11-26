import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessageFromDataCollector extends StatefulWidget {
  final int id;
  const MessageFromDataCollector({super.key, required this.id});

  @override
  _MessageFromDataCollectorState createState() =>
      _MessageFromDataCollectorState();
}

class _MessageFromDataCollectorState extends State<MessageFromDataCollector> {
  final TextEditingController _messsageToDatacollector =
      TextEditingController();
  final TextEditingController _messageFromDataCollector =
      TextEditingController();

  Future<void> _fetchUserInfo() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/getNonMovableData/${widget.id}'));
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);

        setState(() {
          _messsageToDatacollector.text = userData['Message_from_Admin'];
          _messageFromDataCollector.text = userData['Message_To_Admin'];
        });
      } else {
        // Handle error
        print('Failed to fetch user info');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updateUserInfo() async {
    try {
      final response = await http.put(
        Uri.parse(
            'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/messageToDatacollectorNonMov/${widget.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Message_from_Admin': _messsageToDatacollector.text,
        }),
      );
      if (response.statusCode == 200) {
        // Update successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('መልእኽቲ ተላኢኹ'),
          ),
        );
        // print('User info updated successfully');
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('መልእኽቲ ኣይተልእኸን'),
          ),
        );
        // print('Failed to update user info');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
      // print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserInfo(); // Fetch initial user info when the widget is first built
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ናይ መልእኽቲ ገፅ'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('\n መልእኽቲ ካብ መረዳእታ ኣካቢ'),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller: _messageFromDataCollector,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                  readOnly: true, // Make the text field read-only
                ),
              ),

              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('\n መልሲ ካብ ኣድሚን'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _messsageToDatacollector, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              // SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: _updateUserInfo,
              //   child: Text('Send'),
              // ),
              ElevatedButton(
                onPressed: () async {
                  final id = widget.id;
                  const seenDataCollectorMessage =
                      1; // Set seen_datacollector_message to 1

                  // Send request to backend to update seen_data_collector and seen_datacollector_message
                  final response = await http.put(
                    Uri.parse(
                        'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/update-seen-admin-non-mov/$id'),
                    headers: {
                      'Content-Type': 'application/json',
                    },
                    body: jsonEncode({
                      'seen_datacollector_message': seenDataCollectorMessage
                    }),
                  );

                  if (response.statusCode == 200) {
                    final result = jsonDecode(response.body);
                    if (result['message'] ==
                        'Seen data collector updated successfully') {
                      // Call _updateUserInfo function
                      _updateUserInfo();
                    } else {
                      print(
                          'Error updating seen Admin Message: ${result['message']}');
                    }
                  } else {
                    print('Error updating seen Admin Message');
                  }
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
