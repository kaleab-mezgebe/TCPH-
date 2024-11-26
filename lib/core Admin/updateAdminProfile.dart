import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class Updateadminprofile extends StatefulWidget {
  final String? id;
  const Updateadminprofile({super.key, required this.id});

  @override
  _UpdateadminprofileState createState() => _UpdateadminprofileState();
}

class _UpdateadminprofileState extends State<Updateadminprofile> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String _firstName = '';
  String _lastName = '';
  String _gender = '';
  String _email = '';
  String _phoneNumber = '';
  String _position = '';
  String _username = '';
  String _password = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAndUpdateUserData();
  }

  Future<void> _getAndUpdateUserData() async {
    try {
      final url =
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/updatedatacollector/${widget.id}';
      final dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final userData = response.data;
        setState(() {
          _firstName = userData['first_name'] ?? '';
          _lastName = userData['last_name'] ?? '';
          _gender = userData['gender'] ?? '';
          _email = userData['email'] ?? '';
          _phoneNumber = userData['phone_number'] ?? '';
          _position = userData['position'] ?? '';
          _username = userData['username'] ?? '';
          _password = userData['password'] ?? '';
          _isLoading = false;
        });
      } else {
        print('Failed to fetch user data');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Generate a random password
  String _generateRandomPassword() {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(
        6, (index) => characters[random.nextInt(characters.length)]).join();
  }

  // Hash the password using SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _updateUserData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // Hash the password here if provided
    String hashedPassword = _hashPassword(_password);

    try {
      final url =
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/updatedatacollector/${widget.id}';
      final dio = Dio();
      final data = {
        'first_name': _firstName,
        'last_name': _lastName,
        'gender': _gender,
        'email': _email,
        'phone_number': _phoneNumber,
        'position': _position,
        'username': _username,
        'password': hashedPassword,
      };
      final response = await dio.put(url, data: data);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ብዝግባእ ተመሓይሹ'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ምምሕያሽ ኣይተኽኣለን'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('መመሓየሺ ቅጥዒ'),
        backgroundColor: Colors.blue,
        // actions: [
        //   if (!_isLoading)
        //     IconButton(
        //       onPressed: _updateUserData,
        //       icon: const Icon(Icons.save),
        //     ),
        // ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        initialValue: _firstName,
                        decoration: const InputDecoration(labelText: 'ሽም'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ሽም ይምልኡ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _firstName = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _lastName,
                        decoration: const InputDecoration(labelText: 'ሽም ኣቦ'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ሽም ኣቦ ይምልኡ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _lastName = value!;
                        },
                      ),
                      const Text('ፆታ'),
                      const SizedBox(height: 16.0),
                      ListTile(
                        title: const Text('ወዲ ተባዕታይ'),
                        leading: Radio<String>(
                          value: 'ወዲ ተባዕታይ',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('ጓል ኣንስተይቲ'),
                        leading: Radio<String>(
                          value: 'ጓል ኣንስተይቲ',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _email,
                        decoration: const InputDecoration(labelText: 'ኢመይል'),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _phoneNumber,
                        decoration: const InputDecoration(labelText: 'ስልኪ ቑፅሪ'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ስልኪ ቑፅሪ የእትዉ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _position,
                        decoration:
                            const InputDecoration(labelText: 'ዓይነት ስራሕ'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ዓይነት ስራሕ ይምልኡ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _position = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _username,
                        decoration: const InputDecoration(
                            labelText: 'ናይ ተጠቃማይ መፍለዪ ሽም'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ናይ ተጠቃማይ ሽም ኣይተፈጠረን';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                      ),

                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        child: const Text('ሓድሽ መሕለፊ ቓል ፍጠር'),
                        onPressed: () {
                          setState(() {
                            _password =
                                _generateRandomPassword(); // Generate and set the random password
                          });
                          print('መሕለፊ ቓል: $_password'); // Debug print
                        },
                      ),
                      Text(
                          'መሕለፊ ቓል: $_password'), // Display the generated password
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _updateUserData();
                          }
                        },
                        child: const Text('መዝግብ'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
