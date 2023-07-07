import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShardTest extends StatefulWidget {
  const ShardTest({super.key});

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<ShardTest> {
  int readValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saving data'),
      ),
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Read'),
              onPressed: () {
                setState(() {
                  _read();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                _save();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Save 값 : $readValue'),
          ),
        ],
      ),
    );
  }

  // Replace these two methods in the examples that follow

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'my_int_key';
    final value = prefs.getInt(key) ?? 0;
    readValue = value;
    print('read: $value');
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'my_int_key';
    const value = 42;
    prefs.setInt(key, value);
    print('saved $value');
  }
}
