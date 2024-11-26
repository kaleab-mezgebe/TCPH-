import 'package:flutter/material.dart';
import '../loginPage.dart';
import 'viewMyProfile.dart';
import 'updateMyProfile.dart';
import '../data collectors/AboutDeveloper.dart';
import 'addNewAdmin.dart';
import 'viewAdmins.dart';
import 'viewNonMovableData.dart';
import 'viewMovableData.dart';
import 'viewDatacollectors.dart';
import 'viewDatacollectorsReport.dart';

class CoreAdminHome extends StatefulWidget {
  const CoreAdminHome({super.key});

  @override
  _CoreAdminHomeState createState() => _CoreAdminHomeState();
}

class _CoreAdminHomeState extends State<CoreAdminHome> {
  String? _username;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      _username = args as String;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('ናይ ዋና ኣድሚን ገጽ'),
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
                child: Text('ሓድሽ ኣድሚን መዝግብ'),
              ),
              trailing:
                  const Icon(Icons.add_circle_outline, color: Colors.blue),
              onTap: () {
                // Navigate

                // Navigate to the Viewmyprofile screen and pass the username
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Addnewadmin(username: _username),
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
                child: Text('ዝርዝር ኣድሚናት'),
              ),
              trailing: const Icon(Icons.visibility, color: Colors.blue),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewAdmins(),
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
                child: Text('መረዳእታ ኣከብቲ'),
              ),
              trailing: const Icon(Icons.library_books, color: Colors.blue),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewDataCollectors(),
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
                child: Text('ፀብፃብ ስለ መረዳእታ ኣከብቲ'),
              ),
              trailing: const Icon(Icons.library_books, color: Colors.blue),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Viewdatacollectorsreport(),
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
                child: Text('ተንቐሳቐስቲ ሓድጊታት'),
              ),
              trailing: const Icon(Icons.library_books, color: Colors.blue),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewEachMovDataCollectorDatas(),
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
                child: Text('ዘይንቐሳቐሱ ሓድጊታት'),
              ),
              trailing: const Icon(Icons.library_books, color: Colors.blue),
              onTap: () {
                // Navigate to the EditProfile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ViewEachNonMovDataCollectorDatas(),
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
                          UpdateUserInfoPage(username: _username)),
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
