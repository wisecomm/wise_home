import 'package:flutter/material.dart';

import '../../../constants.dart';

class MenuBoardPanel extends StatelessWidget {
  final Function(int worktype) onChanged;

  const MenuBoardPanel({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      const int menu_count_width = 2;
      const int menu_count_height = 2;
      double itemHeight = constraints.maxHeight / menu_count_height;
      double itemWidth = constraints.maxWidth / menu_count_width;

      double itemSize;
      if (itemHeight > itemWidth) {
        itemSize = itemWidth / 1.2;
      } else {
        itemSize = itemHeight / 1.2;
      }

      return Container(
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: itemSize,
                    width: itemSize,
                    child: GestureDetector(
                      child: _menuItem("출 근", "assets/images/work_in_50.png"),
                      onTap: () {
                        onChanged(1);
                      },
                    )),
                SizedBox(
                    height: itemSize,
                    width: itemSize,
                    child: GestureDetector(
                      child: _menuItem("퇴 근", "assets/images/work_out_64.png"),
                      onTap: () {
                        onChanged(2);
                      },
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: itemSize,
                    width: itemSize,
                    child: GestureDetector(
                      child: _menuItem("반 차", "assets/images/work_half_50.png"),
                      onTap: () {
                        onChanged(3);
                      },
                    )),
                SizedBox(
                    height: itemSize,
                    width: itemSize,
                    child: GestureDetector(
                      child: _menuItem("휴 가", "assets/images/work_hol_50.png"),
                      onTap: () {
                        onChanged(4);
                      },
                    )),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _menuItem(name, image) {
    return Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(image, fit: BoxFit.fitWidth),
            const SizedBox(height: 5),
            Text(
              name,
              style:
                  const TextStyle(fontSize: 18 /*fontWeight: FontWeight.bold*/
                      ),
            ),
          ],
        ));
  }
}
