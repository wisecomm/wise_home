import 'package:flutter/material.dart';
import '../testmock/list_photos.dart';

import 'components/menu_board_panel.dart';
import 'mock_work_info.dart';
import 'worktop.dart';

class WorkGooff extends StatefulWidget {
  const WorkGooff({super.key});

  @override
  State<WorkGooff> createState() => _MyPageState();
}

class _MyPageState extends State<WorkGooff> {
  List<WorkInfo> workInfo = [];
  late WorkInfo work1;
  var work2;
  var work3;
  var work4;
  /*
  var work2 = WorkInfo.getCheckList(workInfo, 1);
  var work3 = WorkInfo.getCheckList(workInfo, 2);
  var work4 = WorkInfo.getCheckList(workInfo, 3);
  */

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) => _formInit(context));
  }

  // 폼 초기화
  _formInit(BuildContext context) async {
    Photos.loadListData(context).then((value) {
      setState(() {
        // 데이터 샛팅
        final Iterable itlist = WorkInfo.dummyData;
        workInfo = itlist.map((model) => WorkInfo.fromJson(model)).toList();
        debugPrint("workInfo=$workInfo.toString()");

        work1 = WorkInfo.getCheckList(workInfo, 0);
        work2 = WorkInfo.getCheckList(workInfo, 1);
        work3 = WorkInfo.getCheckList(workInfo, 2);
        work4 = WorkInfo.getCheckList(workInfo, 3);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: WorkTop(workInfo: workInfo)),
        Expanded(
          child: MenuBoardPanel(
            onChanged: (worktype) {
              setState(
                () {
                  WorkInfo worktemp;
                  if (worktype == 1) {
                    worktemp = work1;
                  } else if (worktype == 2) {
                    worktemp = work2;
                  } else if (worktype == 3) {
                    worktemp = work3;
                  } else if (worktype == 4) {
                    worktemp = work4;
                  } else {
                    return;
                  }

                  if (worktemp.workcheckBool == false) {
                    worktemp.workcheck = "true";
                  } else {
                    worktemp.workcheck = "false";
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
