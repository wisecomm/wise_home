import 'package:flutter/material.dart';

class WorkBottom extends StatelessWidget {
  const WorkBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.all(16),
      color: Colors.greenAccent,
      child: menuGridView(),
    );
  }

  LayoutBuilder menuGridView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const int menu_count_width = 2;
        const int menu_count_height = 2;
/*        
        final double itemHeight =
            (constraints.maxHeight - 140) / _menu_count_height;
        final double itemWidth = constraints.maxHeight / _menu_count_width;
*/
        final double itemHeight = constraints.maxHeight / menu_count_height;
        final double itemWidth = constraints.maxWidth / menu_count_width;

        return GridView.count(
          crossAxisCount: menu_count_width,
          childAspectRatio: (itemWidth / itemHeight),
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
//          padding: EdgeInsets.all(defaultPadding),
//          mainAxisSpacing: 20,
//          crossAxisSpacing: 10,
          children: <Widget>[
            Container(
              color: Colors.white,
              width: itemWidth / 2,
              height: itemHeight / 2,
              child: SizedBox(
                width: 120,
                height: 30,
                child: Container(
                    width: 50, color: Colors.red, child: const Text("test")),
              ),
            ),
            /*
            GestureDetector(
              child: _createMenuGridCell('출 근', 'images/social/facebook.png'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            InkWell(
              child: _createMenuGridCell('퇴 근', 'images/social/instagram.png'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              child: _createMenuGridCell('반 차', 'images/social/facebook.png'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              child: _createMenuGridCell('휴 가', 'images/social/instagram.png'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            */
          ],
        );
      },
    );
  }

  Card _createMenuGridCell(name, image) {
    return Card(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(image),
            const SizedBox(height: 10),
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18, /*fontWeight: FontWeight.bold*/
                ),
              ),
            ),
          ],
        ));
  }
}
