import 'package:flutter/material.dart';
import '../../pages/input_form/input_form01.dart';
import '../../pages/workgooff/work_gooff.dart';
import '../../pages/worklist/work_list.dart';

// 참조 : https://blog.logrocket.com/how-to-build-a-bottom-navigation-bar-in-flutter/
class TabbarBottom extends StatefulWidget {
  TabbarBottom({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

final keyWorkListState = new GlobalKey<WorkListState>();

class _MyPageState extends State<TabbarBottom> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      keyWorkListState.currentState?.fnLoadData();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pages = <Widget>[
    WorkGooff(),
    WorkList(
      key: keyWorkListState,
    ),
    InputForm01(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work 관리'),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: '출퇴근',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: '목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '샛팅',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
