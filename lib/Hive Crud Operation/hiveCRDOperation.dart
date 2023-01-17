import 'package:flutter/material.dart';
import 'package:gtd/all%20Screen/widgets/textWidget.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveCRUDTest extends StatefulWidget {
  const HiveCRUDTest({Key? key}) : super(key: key);

  @override
  State<HiveCRUDTest> createState() => _HiveCRUDTestState();
}

class _HiveCRUDTestState extends State<HiveCRUDTest> {
  late Box box;
  var text1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    openBox();
  }

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('textBox');
    return;
  }

  void putData() {
    box.put('name', 'prince');
  }

  void getData() {
    setState(() {
      text1 = box.get('name');
    });
  }

  void updateData() {
    box.put('name', 'ahmad nazir');
  }

  void deleteData() {
    box.delete('name');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'HIVE CRUD',
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            text1 == null
                ? const Text(
                    'Nothing',
                    style: TextStyle(color: AppColors.blueCat),
                  )
                : text(
                    context,
                    text1,
                    23.0,
                  ),
            ElevatedButton(
              onPressed: () {
                putData();
              },
              child: const Text('put Data'),
            ),
            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: const Text('Get Data'),
            ),
            ElevatedButton(
              onPressed: () {
                updateData();
              },
              child: const Text('Update Data'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteData();
              },
              child: const Text('Delete Data'),
            ),
          ],
        ),
      ),
    );
  }
}
