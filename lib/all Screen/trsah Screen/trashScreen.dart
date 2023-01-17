import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gtd/models/deleteModel.dart';
import 'package:gtd/models/inboxModel.dart';
import 'package:gtd/models/toDoModel.dart';
import 'package:gtd/providers/deleteProvider.dart';
import 'package:gtd/providers/inboxProvider.dart';
import 'package:gtd/providers/trashProvider.dart';
import 'package:gtd/routes/appRoutes.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:provider/provider.dart';

import '../../models/categoryModel.dart';
import '../../providers/themeProvider.dart';
import '../../utils/constantToast.dart';
import '../widgets/textWidget.dart';

class TrashScreen extends StatefulWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  TextEditingController searchController = TextEditingController();
  InboxProvider inboxprovider = InboxProvider();
  List filterData = [];
  TrashProvider trashProvider = TrashProvider();
  DeleteProvider deleteProvider = DeleteProvider();
  final TextEditingController catName = TextEditingController();
  Color pickerColor = const Color(0xffffffff);
  Color currentColor = const Color(0xffffffff);
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      log(pickerColor.toString());
    });
  }

  bool chekboxvalue1 = false;
  bool chekboxvalue2 = false;
  bool chekboxvalue3 = true;
  String text1 =
      'Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text  Text Text Text Text Text Text';
  final TextEditingController todoTextController = TextEditingController();
  String selectedCate = '';
  int selectedCateIndex = 0;
  var searchvalue;
  @override
  Widget build(BuildContext context) {
    context.watch<TrashProvider>().getCategory();
    context.watch<TrashProvider>().getTODOItem();
    context.watch<DarkThemeProvider>().getdarkTheme();
    context.watch<InboxProvider>().getTODOItem();
    return Consumer<DarkThemeProvider>(builder: (context, prov1, _) {
      return Consumer<TrashProvider>(builder: (context, prov, _) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: prov1.darkTheme == false
                ? AppColors.appThemeColor
                : Colors.black,
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
                                filterData = Provider.of<TrashProvider>(context,
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
                        ? const SizedBox()
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
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            colorPicker(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: prov.categoryList.length == null
                          ? 0
                          : prov.categoryList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (context, i) {
                        CategoryModel cate = prov.categoryList[i];
                        return prov.categoryList.length == null
                            ? const Text('data')
                            : GestureDetector(
                                onTap: () {
                                  selectedCate = cate.name!;
                                  selectedCateIndex = i;
                                },
                                child: categoryWidget(cate.name.toString(),
                                    cate.color.toString(), i),
                              );
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              prov.todoList == null ? 0 : prov.todoList.length,
                          itemBuilder: (context, i) {
                            TodoModel todoCat = prov.todoList[i];

                            return prov.todoList.length <= 0
                                ? const Text("No data")
                                : selectedCate == todoCat.catgName
                                    ? todoCat.status == 'start'
                                        ? Row(
                                            children: [
                                              searchvalue == null
                                                  ? SizedBox()
                                                  : Text(searchvalue.toString(),
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                              containerData(
                                                todoCat.text.toString(),
                                                todoCat.dateTime,
                                                todoCat,
                                                i,
                                              )
                                            ],
                                          )
                                        : const SizedBox()
                                    : const SizedBox();
                          },
                        ),
                        Consumer<InboxProvider>(builder: (context, prov, _) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: prov.todoList.length == null
                                  ? 0
                                  : prov.todoList.length,
                              itemBuilder: (context, i) {
                                InboxModel inbCate = prov.todoList[i];

                                return prov.todoList.length <= 0
                                    ? const Text("No data")
                                    : inbCate.referenceStatus.toString() ==
                                            'true'
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              inboxContainerData(inbCate, i),
                                            ],
                                          )
                                        : const SizedBox();
                              });
                        }),
                        SizedBox(
                          height: 40.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            addTodo(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(18.h),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

  Widget inboxContainerData(
    InboxModel holedata,
    int indexValue,
    // textValue,
    // dateTimeValue,
    // holedata,
    // indexValue,
  ) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (val) {
              inboxprovider.deleteTODOItem(indexValue);
            },
            backgroundColor: AppColors.reedColor,
            foregroundColor: Colors.white,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                text(
                  context,
                  holedata.dateTime,
                  10.sp,
                  boldText: FontWeight.w600,
                  fontFamily: "Hiragino Sans",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget categoryWidget(text1, colorvalue, indexValue) {
    return Container(
      width: 110.w,
      height: 35.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: selectedCateIndex == indexValue
              ? Colors.black
              : Colors.transparent,
        ),
        color: Color(
          int.parse(colorvalue),
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Align(
        alignment: Alignment.center,
        child: text(
          context,
          text1,
          15.sp,
          boldText: FontWeight.w700,
          color: AppColors.textDarkColor,
        ),
      ),
    );
  }

  Widget containerData(
    textValue,
    dateTimeValue,
    holedata,
    indexValue,
  ) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // onPressed: doNothing,
            onPressed: (val) {
              deleteProvider.addDeleteItem(DeleteModel(
                catgName: holedata.catgName,
                todotext: holedata.text,
                dateTime: holedata.dateTime,
                todoName: trashProvider.trashBox,
              ));
              log('data added in Delete model');
              trashProvider.deleteTODOItem(indexValue);
            },
            backgroundColor: AppColors.reedColor,
            foregroundColor: Colors.white,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
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
                  text: textValue,
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
                text(context, dateTimeValue, 10.sp,
                    boldText: FontWeight.w600, fontFamily: "Hiragino Sans"),
              ],
            )
          ],
        ),
      ),
    );
  }

  void colorPicker(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.r),
          ),
        ),
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
                      spreadRadius: 2,
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: catName,
                    onSaved: (value) {
                      catName.text = value!;
                    },
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textDarkColor,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w300),
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Category Name',
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
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlockPicker(
                  pickerColor: pickerColor,
                  availableColors: const [
                    Colors.deepOrange,
                    Colors.pink,
                    Colors.purple,
                    Colors.blue,
                    Colors.lightBlue,
                    Colors.lightBlueAccent,
                    Colors.blueAccent,
                    Colors.orange,
                    Colors.green,
                    Colors.greenAccent,
                    Colors.lightGreen,
                    Colors.yellow,
                    Colors.orangeAccent,
                    Colors.deepPurple,
                    Colors.brown,
                    Colors.grey,
                    Colors.blueGrey,
                    Colors.cyanAccent,
                    Colors.yellowAccent,
                    Colors.tealAccent,
                    Colors.pinkAccent,
                  ],
                  onColorChanged: changeColor,
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
                      setState(() => currentColor = pickerColor);
                      if (catName.text.isNotEmpty) {
                        log(pickerColor.toString());
                        String hex = '0x${pickerColor.value.toRadixString(16)}';
                        trashProvider.addCategory(
                            CategoryModel(name: catName.text, color: hex));
                        Navigator.of(context).pop();
                        log(catName.text);
                        log(hex);
                      } else {
                        ToastUtils.showCustomToast(
                          context,
                          "Name is Missing",
                          Colors.red,
                        );
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
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
                          controller: todoTextController,
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
                            if (todoTextController.text.isNotEmpty &&
                                selectedCate.isNotEmpty) {
                              trashProvider.addTODOItem(
                                TodoModel(
                                  catgName: selectedCate,
                                  text: todoTextController.text,
                                  dateTime: DateTime.now().toString(),
                                  status: 'start',
                                ),
                              );

                              AppRoutes.pop(context);
                              ToastUtils.showCustomToast(
                                  context, "TODO is Added", Colors.green);
                            } else {
                              ToastUtils.showCustomToast(
                                  context,
                                  "Please Select Category and Todo Text ",
                                  Colors.red);
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
