import 'package:flutter/material.dart';
import '../testmock/list_photos.dart';

class WorkList extends StatefulWidget {
  const WorkList({super.key});

  @override
  State<WorkList> createState() => WorkListState();
}

class WorkListState extends State<WorkList> {
  List<Photos> listPhotos = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _formInit(context));
  }

  // 폼 초기화
  _formInit(BuildContext context) async {
    fnLoadData();
  }

  void fnLoadData() {
    if (listPhotos.isEmpty) {
      Photos.loadListData(context).then((value) {
        setState(() {
          listPhotos = value;
        });
      });
    } else {
      debugPrint("이미 데이터가 로딩되었습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _wCicleIconDataButton(Icons.navigate_before),
            const Text("2021.06", style: TextStyle(fontSize: 18)),
            _wCicleIconDataButton(Icons.navigate_next),
          ],
        ),
        Expanded(child: _buildView(context, listPhotos)),
      ],
    );
  }

  Widget _buildView(BuildContext context, List<Photos> data) {
    if (data.isEmpty) {
      return ListView(
        shrinkWrap: true,
        children: [],
      );
    }

    return ListView(
      shrinkWrap: true,
      children: data.map((data) => _buildListTitle(context, data)).toList(),
      /*
      children: [
        _buildListTitle(context, data[0]),
        _buildListTitle(context, data[0]),
      ],
      */
    );
  }

  Widget _buildListTitle(BuildContext context, Photos data) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: ListTile(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text("01",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text(
                  "목요일",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            // todo: 높이 자동 계산 수정 필요
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                width: 30,
                color: Colors.red,
                thickness: 2,
              ),
            ),
            Column(
              children: const [
                Text("출근 09:00 오전", style: TextStyle(fontSize: 16)),
                Text("퇴근 07:00 오후", style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
        trailing: Column(children: const <Widget>[
          Text("29분", style: TextStyle(color: Colors.pink, fontSize: 16)),
          Text("출근", style: TextStyle(color: Colors.green, fontSize: 16)),
        ]),
        onTap: () {
/*        
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkListDetail(description: data.url),
              ),
            );
*/
        },
      ),
    );
  }

  Widget _wCicleIconDataButton(IconData icon) {
    return RawMaterialButton(
      onPressed: () {},
      child: Icon(
        icon,
        color: Colors.blue,
      ),
      shape: const CircleBorder(side: BorderSide(width: 2, color: Colors.blue)),
      fillColor: Colors.white,
      //padding: const EdgeInsets.all(15.0),
    );
  }
}
