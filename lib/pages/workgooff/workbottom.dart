import 'package:flutter/material.dart';

import 'components/menu_board_panel.dart';

class WorkBottom extends StatelessWidget {
  const WorkBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuBoardPanel(
      onChanged: (worktype) {},
    );
  }
}
