import 'package:flutter/material.dart';
import '../loginPage.dart';
import 'viewMyProfile.dart';
import 'updateMyProfile.dart';
import '../data collectors/AboutDeveloper.dart';
import 'viewDatacollectorsFullNamesMov.dart';
import 'viewDatacollectorsFullNamesNoMov.dart';
import 'addNewDatacollector.dart';
import 'viewDatacollectors.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String? _username;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      _username = args as String;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('ናይ ኣድሚን ዋና ገጽ'),
        backgroundColor: Colors.blue, // Set the background color to blue
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Card(
            elevation: 10.0,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: const DefaultTextStyle(
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
                child: Text('ሓድሽ መረዳእታ ኣካቢ መዝግብ'),
              ),
              trailing:
                  const Icon(Icons.add_circle_outline, color: Colors.blue),
              onTap: () {
                // Navigate

                // Navigate to the Viewmyprofile screen and pass the username
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Addnewdatacollector(username: _username),
                  ),
                );
              },
            ),
          ),
          Card(
            elevation: 10.0,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: const DefaultTextStyle(
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
                child: Text('ዝርዝር መረዳእታ ኣከብቲ'),
              ),
              trailing: const Icon(Icons.visibility, color: Colors.blue),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewDataCollectors(username: _username),
                  ),
                );
              },
            ),
          ),
          Card(
            elevation: 10.0,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: const DefaultTextStyle(
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold),
                child: Text('ዝተኣከቡ ተንቐሳቐስቲ ሓድግታት'),
              ),
              trailing:
                  const Icon(Icons.add_circle_outline, color: Colors.blue),
              // Navigate to the Viewmyprofile screen and pass the username
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewDataCollectorsFullNameMov(username: _username),
                  ),
                );
              },
            ),
          ),
          Card(
            elevation: 10.0,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: const DefaultTextStyle(
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold),
                child: Text('ዝተኣከቡ ዘይንቐሳቐሱ ሓድግታት'),
              ),
              trailing: const Icon(Icons.visibility, color: Colors.blue),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewDataCollectorsFullNameNonMov(username: _username),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('ውልቃዊ ሓበሬታ'),
              trailing: const Icon(Icons.visibility),
              onTap: () {
                // Navigate to the Viewmyprofile screen and pass the username
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Viewmyprofile(username: _username),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('ምምሕያሽ ውልቃዊ ሓበሬታ'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UpdateMyProfile(username: _username)),
                );
              },
            ),
            ListTile(
              title: const Text('ስለ እዚ ሶፍትዌር ኣማዕበልቲ'),
              trailing: const Icon(Icons.book),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutDeveloperScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('ካብዚ ገጽ ውፃእ'),
              trailing: const Icon(Icons.logout),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
