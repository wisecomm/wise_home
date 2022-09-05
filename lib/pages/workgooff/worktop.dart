import 'package:flutter/material.dart';

import '../../constants.dart';
import 'chart.dart';
import 'components/round_check_box.dart';
import 'mock_work_info.dart';

class WorkTop extends StatelessWidget {
  final List<WorkInfo> workInfo;

  const WorkTop({
    Key? key,
    required this.workInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var work1 = WorkInfo.getCheckList(workInfo, 0);
    var work2 = WorkInfo.getCheckList(workInfo, 1);
    var work3 = WorkInfo.getCheckList(workInfo, 2);
    var work4 = WorkInfo.getCheckList(workInfo, 3);

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chart(),
            Container(
              padding: EdgeInsets.fromLTRB(50, 2, 50, 2),
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                workLastText(work1, work2, work3, work4),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Column(
                    children: [
                      RoundCheckBox(
                        label: "출근",
                        value: work1.workcheckBool,
                        onChanged: (bool? newValue) {
                          print("Clieck=" + newValue.toString());
                        },
                      ),
                      Text(
                        work1.worktime,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Column(
                    children: [
                      RoundCheckBox(
                        label: "퇴근",
                        value: work2.workcheckBool,
                        onChanged: (bool? newValue) {
                          print("Clieck=" + newValue.toString());
                        },
                      ),
                      Text(
                        work2.worktime,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String workLastText(
      WorkInfo work1, WorkInfo work2, WorkInfo work3, WorkInfo work4) {
    String retText = "";
    if (work1.workcheckBool == true) retText = "출근";
    if (work2.workcheckBool == true) retText = "퇴근";
    if (work3.workcheckBool == true) retText = "반차";
    if (work4.workcheckBool == true) retText = "휴가";

    return retText;
  }
}
