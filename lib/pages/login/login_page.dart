import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyState();
}

class _MyState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text('Work 관리'),
        title: const Text('소프트원 Work 관리'),
      ),
      body: const Body(),
    );
  }
}
