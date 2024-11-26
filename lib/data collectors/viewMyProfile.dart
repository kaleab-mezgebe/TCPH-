import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Viewmyprofile extends StatefulWidget {
  final String? username;

  const Viewmyprofile({super.key, required this.username});

  @override
  _ViewmyprofileState createState() => _ViewmyprofileState();
}

class _ViewmyprofileState extends State<Viewmyprofile> {
  String _username = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _gender = '';
  String _email = '';
  String _phoneNumber = '';
  String _position = '';
  String _role = '';

  @override
  void initState() {
    super.initState();
    _getProfileFromServer();
  }

  Future<void> _getProfileFromServer() async {
    final response = await http.get(Uri.parse(
        'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/get-profile?username=${widget.username}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.containsKey('data')) {
        Map<String, dynamic> profileData = jsonData['data'];
        setState(() {
          _username = profileData['username'].toString();
          _password = profileData['password'].toString();
          _firstName = profileData['firstName'].toString();
          _lastName = profileData['lastName'].toString();
          _gender = profileData['gender'].toString();
          _email = profileData['email'].toString();
          _phoneNumber = profileData['phoneNumber'].toString();
          _position = profileData['position'].toString();
          _role = profileData['role'].toString();
        });
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Add this line to remove the debug banner

      home: Scaffold(
        appBar: AppBar(
          title: const Text('ውልቃዊ ሓበሬታ'),

          backgroundColor: Colors.blue, // Set the background color to blue

          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Text(
                      '${_firstName.isNotEmpty ?? false ? _firstName[0] : ''}'
                      '${_lastName.isNotEmpty ?? false ? _lastName[0] : ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  '${_firstName ?? ''} ${_lastName ?? ''}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '$_position - $_role',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('ኢመይል'),
                  subtitle: Text(_email),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('ስልኪ ቑፅሪ'),
                  subtitle: Text(_phoneNumber),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('ፆታ'),
                  subtitle: Text(_gender),
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('መፍለዪ ሽም'),
                  subtitle: Text(_username),
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('መሕለፊ ቓል'),
                  subtitle: Text(_password),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
