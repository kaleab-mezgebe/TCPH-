import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:math';

class Addnewadmin extends StatefulWidget {
  final String? username;
  const Addnewadmin({super.key, required this.username});

  @override
  _AddnewadminState createState() => _AddnewadminState();
}

class _AddnewadminState extends State<Addnewadmin> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  String? _gender;
  late String _email;
  late String _phoneNumber;
  late String _position;
  late String _username;
  String _password = ''; // Initialize _password
  String? _selectedRole;
  static const List<String> roles = ['ኣድሚን'];

  // Method to generate a random password
  String _generateRandomPassword() {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    String password = '';

    for (int i = 0; i < 6; i++) {
      password += characters[random.nextInt(characters.length)];
    }

    return password;
  }

  // Hash the password using SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // Hash the generated password
    String hashedPassword = _hashPassword(_password);

    const url =
        'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/addnewadmin';

    try {
      final dio = Dio();
      final formData = FormData();
      formData.fields
        ..add(MapEntry('username', _username))
        ..add(MapEntry('password', hashedPassword)) // Use the hashed password
        ..add(MapEntry('firstName', _firstName))
        ..add(MapEntry('lastName', _lastName))
        ..add(MapEntry('gender', _gender ?? ''))
        ..add(MapEntry('email', _email))
        ..add(MapEntry('phoneNumber', _phoneNumber))
        ..add(MapEntry('position', _position))
        ..add(MapEntry('role', _selectedRole ?? ''));

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ምዝገባ ተሳኺዑ'),
          ),
        );

        // Clear the form fields
        _formKey.currentState!.reset();
        setState(() {
          _password = ''; // Resetting password field
          _firstName = '';
          _lastName = '';
          _gender = null;
          _email = '';
          _phoneNumber = '';
          _position = '';
          _username = '';
          _selectedRole = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ምዝገባ ኣይተሳኽዐን'),
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
        title: const Text('መመዝገቢ ቅጥዒ'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
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
                const Text('ፆታ'),
                const SizedBox(height: 16.0),
                ListTile(
                  title: const Text('ወዲ ተባዕታይ'),
                  leading: Radio<String>(
                    value: 'ወዲ ተባዕታይ',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
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
                        _gender = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ኢመይል',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ስልኪ ቑፅሪ',
                  ),
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
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ሓድሽ መፍለዪ ሽም ይፍጠሩሎም',
                  ),
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
                Text('መሕለፊ ቓል: $_password'), // Display the generated password
                const SizedBox(height: 16.0),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'መደብ ስራሕ',
                  ),
                  value: _selectedRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                  items: roles.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'መደብ ስራሕ ይምልኡ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _registerUser();
                      _formKey.currentState!.reset(); // Add this line
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
