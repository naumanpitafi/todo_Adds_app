import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gtd/models/categoryModel.dart';
import 'package:gtd/models/deleteModel.dart';
import 'package:gtd/models/toDoModel.dart';
import 'package:gtd/providers/calenderProvider.dart';
import 'package:gtd/providers/deleteProvider.dart';
import 'package:gtd/providers/doitProvider.dart';
import 'package:gtd/providers/nextActionProvider.dart';
import 'package:gtd/providers/projectProvider.dart';
import 'package:gtd/providers/referenceProvider.dart';
import 'package:gtd/providers/somedaymaybeProvider.dart';
import 'package:gtd/providers/trashProvider.dart';
import 'package:gtd/providers/waitingProvider.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:provider/provider.dart';

import '../../providers/themeProvider.dart';
import '../widgets/textWidget.dart';

class DeletedItemScreen extends StatefulWidget {
  const DeletedItemScreen({Key? key}) : super(key: key);

  @override
  State<DeletedItemScreen> createState() => _DeletedItemScreenState();
}

class _DeletedItemScreenState extends State<DeletedItemScreen> {
  TextEditingController searchController = TextEditingController();
  List filterData = [];
  DeleteProvider deleteProvider = DeleteProvider();
  CalenderProvider calenderProvider = CalenderProvider();
  NextActionProvider nextactionProvider = NextActionProvider();
  DoitProvider doitProvider = DoitProvider();
  WaitingProvider waitingProvider = WaitingProvider();
  ProjectListProvider projectListProvider = ProjectListProvider();
  ReferenceProvider referenceProvider = ReferenceProvider();
  SomeDayMaybeProvider somedayMayBeProvider = SomeDayMaybeProvider();
  TrashProvider trashProvider = TrashProvider();
  bool chekboxvalue1 = false;
  @override
  Widget build(BuildContext context) {
    context.watch<DeleteProvider>().getDeleteItem();
    context.watch<DarkThemeProvider>().getdarkTheme();
    return Consumer<DarkThemeProvider>(builder: (context, prov1, _) {
      return Consumer<DeleteProvider>(builder: (context, prov, _) {
        return SafeArea(
          child: Scaffold(
            backgroundColor:
                prov1.darkTheme == false ? AppColors.appThemeColor : Colors.black,
           body: Container(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.trash,
                            color: prov1.darkTheme == false
                                ? AppColors.textDarkColor
                                : Colors.white,
                          ),
                          text(
                            context,
                            'Trash',
                            20.sp,
                            color: prov1.darkTheme == false
                                ? AppColors.textDarkColor
                                : Colors.white,
                            boldText: FontWeight.w600,
                            fontFamily: "Hiragino Kaku Gothic ProN",
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: searchController,
                              onChanged: ((value) {
                                setState(() {
                                  filterData = Provider.of<DeleteProvider>(context,
                                          listen: false)
                                      .todoList
                                      .where(
                                        (filt) => filt.text
                                            .toString()
                                            .toUpperCase()
                                            .contains(searchController.text
                                                .toString()
                                                .toUpperCase()),
                                      )
                                      .toList();
                                });
                              }),
                              decoration: InputDecoration(
                                fillColor: AppColors.whiteCat,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: AppColors.textColor,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    )),
                                filled: true,
                                // prefixIcon: icondata,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 10.w,
                                ),
                                hintText: 'Enter Description',
                                hintStyle: const TextStyle(
                                  color: Color(0xff929292),
                                ),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      searchController.text.isEmpty
                          ? SizedBox()
                          : filterData.length == 0
                              ? text(
                                  context,
                                  'Empty',
                                  22.sp,
                                  boldText: FontWeight.w700,
                                  color: AppColors.appThemeColor,
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount:
                                      filterData.isEmpty ? 0 : filterData.length,
                                  itemBuilder: (BuildContext context, i) {
                                    return Text(filterData[i].text.toString());
                                  },
                                ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: prov.categoryList == null
                            ? 0
                            : prov.categoryList.length,
                        itemBuilder: (context, i) {
                          DeleteModel todoCat = prov.categoryList[i];
                          return prov.categoryList.length <= 0
                              ? const Text("No data")
                              : Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.blue,
                                        unselectedWidgetColor:
                                            Colors.grey, // Your color
                                      ),
                                      child: Checkbox(
                                        activeColor: AppColors.reedColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.r)),
                                        value: chekboxvalue1,
                                        onChanged: (value) {
                                        
                                        },
                                      ),
                                    ),
                                    containerData(
                                      todoCat.todotext,
                                      todoCat.dateTime,
                                      todoCat,
                                      i,
                                    ),
                                  ],
                                );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }

  Widget containerData(
    texttodo,
    dateTimetodo,
    DeleteModel holedata,
    indexValue,
  ) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // onPressed: doNothing,
            onPressed: (val) {
              if (holedata.todoName == 'calenderBox') {
                log('calenderBox');
                calenderProvider.addTODOItem(TodoModel(
                  catgName: holedata.catgName,
                  text: holedata.todotext,
                  dateTime: holedata.dateTime,
                  status: 'start',
                ));
                log('data added');
                deleteProvider.deleteDeleteItem(indexValue);
              } else if (holedata.todoName == 'nextActionBox') {
                nextactionProvider.addTODOItem(TodoModel(
                  catgName: holedata.catgName,
                  text: holedata.todotext,
                  dateTime: holedata.dateTime,
                  status: 'start',
                ));
                log('data added');
                deleteProvider.deleteDeleteItem(indexValue);
              } else if (holedata.todoName == 'todoCategoryBox') {
                doitProvider.addTODOItem(TodoModel(
                  catgName: holedata.catgName,
                  text: holedata.todotext,
                  dateTime: holedata.dateTime,
                  status: 'start',
                ));
                log('data added');
                deleteProvider.deleteDeleteItem(indexValue);
              } else if (holedata.todoName == 'waitingBox') {
                waitingProvider.addTODOItem(TodoModel(
                  catgName: holedata.catgName,
                  text: holedata.todotext,
                  dateTime: holedata.dateTime,
                  status: 'start',
                ));
                log('data added');
                deleteProvider.deleteDeleteItem(indexValue);
              } else if (holedata.todoName == 'projectListBox') {
                projectListProvider.addTODOItem(TodoModel(
                  catgName: holedata.catgName,
                  text: holedata.todotext,
                  dateTime: holedata.dateTime,
                  status: 'start',
                ));
                log('data added');
                deleteProvider.deleteDeleteItem(indexValue);
              } else if (holedata.todoName == 'referenceBox') {
                referenceProvider.addTODOItem(TodoModel(
                  catgName: holedata.catgName,
                  text: holedata.todotext,
                  dateTime: holedata.dateTime,
                  status: 'start',
                ));
                log('data added');
                deleteProvider.deleteDeleteItem(indexValue);
              } else if (holedata.todoName == 'somedayMybeBox') {
                somedayMayBeProvider.addTODOItem(TodoModel(
                  catgName: holedata.catgName,
                  text: holedata.todotext,
                  dateTime: holedata.dateTime,
                  status: 'start',
                ));
                log('data added');
                deleteProvider.deleteDeleteItem(indexValue);
              } else if (holedata.todoName == 'trashBox') {
                trashProvider.addTODOItem(TodoModel(
                  catgName: holedata.catgName,
                  text: holedata.todotext,
                  dateTime: holedata.dateTime,
                  status: 'start',
                ));
                log('data added');
                deleteProvider.deleteDeleteItem(indexValue);
              } else {
                log('Something else');
              }
            },
            backgroundColor: AppColors.reedColor,
            foregroundColor: Colors.white,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.only(
          left: 10.h,
          right: 10.h,
          top: 15.h,
          bottom: 15.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: Colors.white,
        ),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                  text: texttodo,
                  style: TextStyle(
                    fontFamily: 'Hiragino Kaku Gothic ProN',
                    color: AppColors.textDarkColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 3.h,
                    bottom: 3.h,
                    left: 5.w,
                    right: 5.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.textDarkColor,
                  ),
                  child: text(
                    context,
                    dateTimetodo,
                    10.sp,
                    color: AppColors.whiteCat,
                    boldText: FontWeight.w600,
                    fontFamily: "Hiragino Sans",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
