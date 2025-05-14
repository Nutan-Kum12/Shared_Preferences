import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var nameController = TextEditingController();
  static const String KEYNAME = "name";
  var nameValue = "";

  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shared Demo')),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var name = nameController.text.toString();
                var prefs = await SharedPreferences.getInstance();
                prefs.setString(KEYNAME, name);
                print('Name saved: $name');
              },
              child: Text('Save'),
            ),
            SizedBox(height: 20),
            Text(nameValue),
            ElevatedButton(
              onPressed: deleteName,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  void getName() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString(KEYNAME);

    setState(() {
      nameValue = getName ?? "No value";
    });
  }

  void deleteName() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(KEYNAME);

    setState(() {
      nameValue = "No value";
    });
  }
}
