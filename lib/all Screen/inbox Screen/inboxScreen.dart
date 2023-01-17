import 'dart:developer';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtd/adMob/bannerAd.dart';
import 'package:gtd/all%20Screen/widgets/textWidget.dart';
import 'package:gtd/models/categoryModel.dart';
import 'package:gtd/models/inboxModel.dart';
import 'package:gtd/models/toDoModel.dart';
import 'package:gtd/providers/inboxProvider.dart';
import 'package:gtd/providers/themeProvider.dart';
import 'package:gtd/routes/appRoutes.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:gtd/utils/constantToast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../box Screen/boxScreen.dart';
import 'whatisitScreen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  TextEditingController searchController = TextEditingController();
  List filterData = [];
  TextEditingController addTodoController = TextEditingController();
  TextEditingController controller = TextEditingController();
  void doNothing(BuildContext context) {}
  BottomDrawerController bottomDrawerCntroller = BottomDrawerController();
  InboxProvider inboxprovider = InboxProvider();
  int intvalue = 0;
  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(
      ad: AdmobHelper.getBannerAd()..load(),
    );
    context.watch<InboxProvider>().getTODOItem();
    context.watch<DarkThemeProvider>().getdarkTheme();
    return Consumer<DarkThemeProvider>(builder: (context, prov1, _) {
      return Consumer<InboxProvider>(
        builder: (context, prov, _) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: prov1.darkTheme == false
                  ? AppColors.appThemeColor
                  : Colors.black,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // addingTodoTextModalBottomSheet();
                  addingModalBottomSheet();
                  // addTodo(context);
                },
                child: Container(
                  height: 250.h,
                  width: 250.w,
                  decoration: const BoxDecoration(
                    color: AppColors.reedColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: AppColors.whiteCat,
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  color: prov1.darkTheme == false
                      ? AppColors.appThemeColor
                      : Colors.black,
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.box,
                            color: prov1.darkTheme == false
                                ? AppColors.textDarkColor
                                : Colors.white,
                            size: 20.0,
                          ),
                          text(context, 'Inbox', 20.sp,
                              boldText: FontWeight.w600,
                              color: prov1.darkTheme == false
                                  ? AppColors.textDarkColor
                                  : Colors.white,
                              fontFamily: "Hiragino Kaku Gothic ProN"),
                          Expanded(
                            child: TextFormField(
                              controller: searchController,
                              onChanged: ((value) {
                                setState(() {
                                  filterData = Provider.of<InboxProvider>(
                                          context,
                                          listen: false)
                                      .todoList
                                      .where(
                                        (filt) => filt.todoText
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
                                  itemCount: filterData.isEmpty
                                      ? 0
                                      : filterData.length,
                                  itemBuilder: (BuildContext context, i) {
                                    return Text(
                                      filterData[i].todoText.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 23.sp,
                                      ),
                                    );
                                  },
                                ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            prov.todoList == null ? 0 : prov.todoList.length,
                        itemBuilder: (context, i) {
                          InboxModel todoCat = prov.todoList[i];
                          return prov.todoList.length <= 0
                              ? const Text("No data")
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textSpanWidget(
                                      todoCat,
                                      i,
                                    ),
                                  ],
                                );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.bottomCenter,
                        child: adWidget,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  void addingModalBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Text',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (controller.text.isNotEmpty) {
                              inboxprovider.addTODOItem(
                                InboxModel(
                                    todoText: controller.text,
                                    dateTime: DateTime.now().toString(),
                                    status: 'start',
                                    extendedate: DateTime.now().toString(),
                                    trashStatus: 'false',
                                    somedayMaybeStatus: 'false',
                                    referenceStatus: 'false'),
                              );
                              AppRoutes.pop(context);
                              ToastUtils.showCustomToast(context,
                                  "Text Added Succesfully", Colors.green);
                            } else {
                              ToastUtils.showCustomToast(
                                  context, "Text Not Added ", Colors.red);
                            }
                          },
                          child: Icon(Icons.send),
                        ),
                      ),
                      autofocus: true,
                      controller: controller,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ));
  }

  Widget finishtextSpanWidget(
    InboxModel holedata,
    indexValue,
  ) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // onPressed: doNothing,
            onPressed: (val) {
              inboxprovider.deleteTODOItem(indexValue);
            },
            backgroundColor: AppColors.reedColor,
            foregroundColor: Colors.white,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        // onTap: () {
        //   // print('adata ');
        //   // AppRoutes.push(
        //   //   context,
        //   //   PageTransitionType.fade,
        //   //   WhatisitScreen(
        //   //     holeData: holedata,
        //   //     indexvalue: indexValue,
        //   //   ),
        //   // );
        // },
        // onLongPress: () {
        //   log('On Long Press is working fine');
        //   _settingModalBottomSheet(holedata, indexValue);
        // },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          // height: 174.h,
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.only(
            left: 5.h,
            right: 5.h,
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
                    text: holedata.todoText,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  text(context, holedata.dateTime, 10.sp,
                      boldText: FontWeight.w600, fontFamily: "Hiragino Sans"),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, top: 2.w, bottom: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.greyCat,
                      borderRadius: BorderRadius.circular(45.r),
                    ),
                    child: text(context, holedata.extendedate, 10.sp,
                        boldText: FontWeight.w600, fontFamily: "Hiragino Sans"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textSpanWidget(
    InboxModel holedata,
    indexValue,
  ) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // onPressed: doNothing,
            onPressed: (val) {
              inboxprovider.deleteTODOItem(indexValue);
            },
            backgroundColor: AppColors.reedColor,
            foregroundColor: Colors.white,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          print('adata ');
          AppRoutes.push(
            context,
            PageTransitionType.fade,
            WhatisitScreen(
              holeData: holedata,
              indexvalue: indexValue,
            ),
          );
        },
        onLongPress: () {
          log('On Long Press is working fine');
          _settingModalBottomSheet(holedata, indexValue);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          // height: 174.h,
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.only(
            left: 5.h,
            right: 5.h,
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
                    text: holedata.todoText,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  text(context, holedata.dateTime, 10.sp,
                      boldText: FontWeight.w600, fontFamily: "Hiragino Sans"),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, top: 2.w, bottom: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.greyCat,
                      borderRadius: BorderRadius.circular(45.r),
                    ),
                    child: text(context, holedata.extendedate, 10.sp,
                        boldText: FontWeight.w600, fontFamily: "Hiragino Sans"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void addingTodoTextModalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          margin: EdgeInsets.only(left: 5.w, right: 5.w),
          padding: EdgeInsets.all(15.h),
          color: Colors.transparent,
          child: Wrap(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: controller,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textDarkColor,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w300,
                      ),
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        hintText: 'Add Text',
                        hintStyle: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textDarkColor,
                            fontFamily: 'Open Sans'),
                        fillColor: const Color(0xFFFFFFFF),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.r),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.r),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.r),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  inboxprovider.addTODOItem(
                    InboxModel(
                        todoText: 'this is Texd',
                        dateTime: DateTime.now().toString(),
                        status: 'start',
                        extendedate: DateTime.now().toString(),
                        trashStatus: 'false',
                        somedayMaybeStatus: 'false',
                        referenceStatus: 'false'),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10.h),
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Align(
                    alignment: Alignment.center,
                    child: text(
                      context,
                      'add',
                      30.sp,
                      boldText: FontWeight.w700,
                      color: AppColors.textDarkColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _settingModalBottomSheet(
    InboxModel holedata,
    indexvalue,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          margin: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
          ),
          color: Colors.transparent,
          child: Wrap(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        AppRoutes.push(context, PageTransitionType.bottomToTop,
                            const BoxScreen());
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: text(context, 'Move Box', 30.sp,
                            boldText: FontWeight.w700,
                            color: AppColors.textDarkColor),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Divider(
                      height: 2,
                      color: AppColors.textColor,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: holedata.todoText));
                        ToastUtils.showCustomToast(
                            context, "Text Coppied!!!", Colors.green);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: text(context, 'Copy', 30.sp,
                            boldText: FontWeight.w700,
                            color: AppColors.textDarkColor),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Divider(
                      height: 2,
                      color: AppColors.textColor,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        inboxprovider.addTODOItem(InboxModel(
                          todoText: holedata.todoText,
                          dateTime: holedata.dateTime,
                          status: 'start',
                          extendedate: holedata.extendedate,
                          trashStatus: holedata.trashStatus,
                          somedayMaybeStatus: holedata.somedayMaybeStatus,
                          referenceStatus: holedata.referenceStatus,
                        ));
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: text(context, 'Duplicate', 30.sp,
                            boldText: FontWeight.w700,
                            color: AppColors.textDarkColor),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Divider(
                      height: 2,
                      color: AppColors.textColor,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        inboxprovider.deleteTODOItem(intvalue);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: text(context, 'Delete', 30.sp,
                            boldText: FontWeight.w700,
                            color: AppColors.textDarkColor),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  AppRoutes.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10.h),
                  height: 60.h,
                  // width: 323.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Align(
                    alignment: Alignment.center,
                    child: text(context, 'Cancel', 30.sp,
                        boldText: FontWeight.w700,
                        color: AppColors.textDarkColor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addTodo(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r))),
              backgroundColor: AppColors.appThemeColor,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.25),
                          )
                        ],
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: addTodoController,
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textDarkColor,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w300),
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: 'Add TODO',
                            hintStyle: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textDarkColor,
                                fontFamily: 'Open Sans'),
                            fillColor: const Color(0xFFFFFFFF),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.r),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.r),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.r),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              width: 90.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: text(context, "Cancel", 24.sp,
                                    color: AppColors.textDarkColor,
                                    boldText: FontWeight.w600),
                              )),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {
                            if (addTodoController.text.isNotEmpty) {
                              inboxprovider.addTODOItem(
                                InboxModel(
                                    todoText: addTodoController.text,
                                    dateTime: DateTime.now().toString(),
                                    status: 'start',
                                    extendedate: DateTime.now().toString(),
                                    trashStatus: 'false',
                                    somedayMaybeStatus: 'false',
                                    referenceStatus: 'false'),
                              );
                              addTodoController.clear();
                              Navigator.of(context).pop();
                            } else {
                              ToastUtils.showCustomToast(
                                  context, "Text is Missing", Colors.red);
                            }
                          },
                          child: Container(
                              width: 90.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              alignment: Alignment.center,
                              child: Align(
                                child: text(context, "  Ok  ", 24.sp,
                                    color: AppColors.textDarkColor,
                                    boldText: FontWeight.w600),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
