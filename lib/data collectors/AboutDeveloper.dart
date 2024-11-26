import 'package:flutter/material.dart';

class AboutListTile extends StatelessWidget {
  final String applicationName;
  final String applicationVersion;
  final String copyright;
  final List<Person> maintainers;

  const AboutListTile({
    super.key,
    required this.applicationName,
    required this.applicationVersion,
    required this.copyright,
    required this.maintainers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          applicationName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'version $applicationVersion',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          copyright,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        const Text('መማዕበልቲ'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: maintainers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${maintainers[index].name} ${maintainers[index].phone_number}(${maintainers[index].email})'),
            );
          },
        ),
      ],
    );
  }
}

class Person {
  final String name;
  final String email;
  final String phone_number;

  const Person(
      {required this.name, required this.email, required this.phone_number});
}

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('መማዕበልቲ ሶፍትዌር'),
        backgroundColor: Colors.blue, // Set the background color to blue
      ),
      body: const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: AboutListTile(
              applicationName: 'TCPH',
              applicationVersion: '1.0.0',
              copyright: 'Copyright 2024 TCTB',
              maintainers: [
                Person(
                    name: 'ቃልኣብ መዝገበ ፍሳሃ\n',
                    email: 'kaleabmezgebe4@gmail.com',
                    phone_number: '0945989369\n'),
                Person(
                    name: 'ዳዊት ኪዱ በላይ\n',
                    email: 'dawit.kidu.b@gmail.com',
                    phone_number: '0933110625\n'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
