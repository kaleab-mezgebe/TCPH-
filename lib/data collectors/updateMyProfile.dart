import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class UpdateUserInfoPage extends StatefulWidget {
  final String? username;
  const UpdateUserInfoPage({super.key, required this.username});
  @override
  _UpdateUserInfoPageState createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage> {
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
  String _newPassword = '';

  String _selectedRole = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAndUpdateUserData();
  }

  Future<void> _getAndUpdateUserData() async {
    try {
      final url =
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/updateMyprofile/${widget.username}'; // Include the user ID in the URL
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
          _selectedRole = userData['role'] ?? '';
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
    // Determine the password to send
    String hashedPassword;

    if (_newPassword.isNotEmpty) {
      // If there is a new password, hash it
      hashedPassword = _hashPassword(_newPassword);
    } else {
      // If no new password provided, use the existing password
      hashedPassword = _password;
    }
    try {
      final url =
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/updateMyprofile/${widget.username}'; // Include the user ID in the URL
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
        'role': _selectedRole,
      };
      final response = await dio.put(url, data: data);

      if (response.statusCode == 200) {
        // print('User data updated successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ብዝግባእ ተመሓይሹ'),
          ),
        );
      } else {
        // print('Failed to update user data');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ምምሕያሽ ኣይተኽኣለን'),
          ),
        );
      }
    } catch (error) {
      // print('Error: $error');
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
        backgroundColor: Colors.blue, // Set the background color to blue

        // actions: [
        //   if (!_isLoading)
        //     IconButton(
        //       onPressed: _updateUserData,
        //       icon: const Icon(Icons.save),
        //     ),
        // ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
                        decoration: const InputDecoration(
                          labelText: 'ሽም',
                        ),
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
                        decoration: const InputDecoration(
                          labelText: 'ሽም ኣቦ',
                        ),
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
                      const Text('\nፆታ'),
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
                        decoration: const InputDecoration(
                          labelText: 'ኢመይል/Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _phoneNumber,
                        decoration: const InputDecoration(
                          labelText: 'ስልኪ ቑፅሪ',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ስልኪ ቑፅሪ የእትዉ';
                          }
                          // Add phone number validation logic here
                          return null;
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _position,
                        decoration: const InputDecoration(
                          labelText: 'ዓይነት ስራሕ',
                        ),
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
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'ሓድሽ መሕለፊ ቓል',
                          border: const OutlineInputBorder(),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          _newPassword = value!;
                        },
                      ),
                      Text('ዝነበረ መሕለፊ ቓል: $_password'), //
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
