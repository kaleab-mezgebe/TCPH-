// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool isPasswordVisible = false;
//   Future<void> login() async {
//     if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
//       // Show a SnackBar for empty username or password
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('ይቕሬታ፣መፍለዪ ሽምን መሕለፊ ቓልን ይምልኡ! '),
//         ),
//       );
//       return;
//     }

//     try {
//       Dio dio = Dio();

//       // Send the login POST request
//       var response = await dio.post(
//         'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/login',
//         data: {
//           'username': usernameController.text,
//           'password': passwordController.text,
//         },
//         options: Options(
//           validateStatus: (status) =>
//               status! < 500, // Accept any status code < 500 as valid
//         ),
//       );

//       // Handle successful login
//       if (response.statusCode == 200) {
//         String role = response.data['role'];

//         // Navigate based on user role
//         Navigator.pushNamed(
//           context,
//           role == 'ኣድሚን'
//               ? '/admin'
//               : role == 'ዋና ኣድሚን'
//                   ? '/core-admin'
//                   : '/data-collector',
//           arguments: usernameController.text,
//         );
//       } else if (response.statusCode == 401) {
//         // Handle 401 Unauthorized
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               response.data['error'] ?? 'ይቕሬታ ዝተሰሓሓተ መፍለይ ሽም ወይ መሕለፊ ቓል ኣእትዮም!',
//             ),
//           ),
//         );
//       } else {
//         // Handle other erroneous responses
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               'ናይ ሰርቨር ፀገም ኣጋጢሙ ኣሎ!',
//             ),
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       // Log the Dio exception and show an error message
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('ናይ ኔትዎርክ ፀገም ስለዘጋጠመ ኢንተርኔትኩም ኣስተኻኽሉ!'),
//         ),
//       );
//     } catch (e) {
//       // Handle any other exceptions
//       print('An unexpected error occurred: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('በይዘኦም ደጊሞም ይሞክሩ እቲ ገፅ ክመፅእ ኣይከኣለን!'),
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Configure the status bar appearance
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.blue[900], // Set status bar color
//       statusBarIconBrightness: Brightness.light, // Set icons brightness
//       statusBarBrightness: Brightness.dark, // For Android
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           const Color(0xFFf2f2f2), // Set the background color to gray
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Center(
//                   child: Icon(
//                     Icons.lock,
//                     color: Colors.red,
//                     size: 150,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'መፍለዪ ሽም',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: Colors.blue[900]!,
//                         width: 2,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: Colors.blue[900]!,
//                         width: 2,
//                       ),
//                     ),
//                     prefixIcon: Icon(Icons.person, color: Colors.blue[900]),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: !isPasswordVisible,
//                   decoration: InputDecoration(
//                     labelText: 'መሕለፊ ቓል',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: Colors.blue[900]!,
//                         width: 2,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: Colors.blue[900]!,
//                         width: 2,
//                       ),
//                     ),
//                     prefixIcon: Icon(Icons.lock, color: Colors.blue[900]),
//                     suffixIcon: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           isPasswordVisible = !isPasswordVisible;
//                         });
//                       },
//                       child: Icon(
//                         isPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.blue[900],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: login,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue[900],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       side: BorderSide(
//                         color: Colors.blue[900]!,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15.0),
//                     child: Text(
//                       'ይእተው',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import the package for connectivity

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false; // Loading state variable

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> login() async {
    // Check for internet connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('እባኮትን ኢንተርኔትን ይፈልጋሉ፡፡'),
        ),
      );
      return; // No internet connection, abort login
    }

    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      // Show a SnackBar for empty username or password
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ይቕሬታ፣መፍለዪ ሽምን መሕለፊ ቓልን ይምልኡ! '),
        ),
      );
      return;
    }

    final hashedPassword =
        _hashPassword(passwordController.text); // Hash the entered password
    print(
        "Hashed Password vs Auth Server: $hashedPassword"); // Log the hashed password

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      Dio dio = Dio();
      // Send the login POST request
      var response = await dio.post(
        'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/login',
        data: {
          'username': usernameController.text,
          'password': hashedPassword, // Use hashed password
        },
        options: Options(
          validateStatus: (status) =>
              status! < 500, // Accept any status code < 500 as valid
        ),
      );

      // Handle successful login
      if (response.statusCode == 200) {
        String role = response.data['role'];
        // Navigate based on user role
        Navigator.pushNamed(
          context,
          role == 'ኣድሚን'
              ? '/admin'
              : role == 'ዋና ኣድሚን'
                  ? '/core-admin'
                  : '/data-collector',
          arguments: usernameController.text,
        );
      } else if (response.statusCode == 401) {
        // Handle 401 Unauthorized
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data['ይቕሬታ ዝተሰሓሓተ መፍለይ ሽም ወይ መሕለፊ ቓል ኣእትዮም!'] ??
                  'ይቕሬታ ዝተሰሓሓተ መፍለይ ሽም ወይ መሕለፊ ቓል ኣእትዮም!',
            ),
          ),
        );
      } else {
        // Handle other erroneous responses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'ናይ ሰርቨር ፀገም ኣጋጢሙ ኣሎ!',
            ),
          ),
        );
      }
    } on DioException catch (e) {
      // Log the Dio exception and show an error message
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ናይ ኔትዎርክ ፀገም ስለዘጋጠመ ኢንተርኔትኩም ኣስተኻኽሉ!'),
        ),
      );
    } catch (e) {
      // Handle any other exceptions
      print('An unexpected error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('በይዘኦም ደጊሞም ይሞክሩ እቲ ገፅ ክመፅእ ኣይከኣለን!'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // End loading
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Configure the status bar appearance
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[900], // Set status bar color
      statusBarIconBrightness: Brightness.light, // Set icons brightness
      statusBarBrightness: Brightness.dark, // For Android
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFf2f2f2), // Set the background color to gray
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(
                    Icons.lock,
                    color: Colors.red,
                    size: 150,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'መፍለዪ ሽም',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue[900]!,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue[900]!,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.blue[900]),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'መሕለፊ ቓል',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue[900]!,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue[900]!,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.blue[900]),
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
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                isLoading // Check loading state to toggle UI
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.blue[900]!,
                              width: 2,
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'ይእተው',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
