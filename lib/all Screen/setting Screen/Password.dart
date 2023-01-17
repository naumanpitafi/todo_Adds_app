import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gtd/all%20Screen/widgets/textWidget.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:gtd/utils/constantToast.dart';
import 'package:gtd/utils/sharedPref.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordSetting extends StatefulWidget {
  const PasswordSetting({Key? key}) : super(key: key);

  @override
  State<PasswordSetting> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PasswordSetting> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  //biometric
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool isBioLogin = false;
  bool canCheckBiometrics = false;
  //switches
  bool boolvalue = false;
  bool boolvalueFaceId = false;
  DarkThemePreference statusHandler = DarkThemePreference();
  bool status = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changestatus();
    changedvalue();
    checkingForBioMetrics();
  }

  changestatus() async {
    bool _status = await statusHandler.getTheme();
    //status = darkThemeProvider.darkTheme;
    setState(() {
      status = _status;
    });

    log(status.toString());
  }

  Future<bool> checkingForBioMetrics() async {
    canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    return canCheckBiometrics;
  }

  changedvalue() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? boolvaluecheck = prefs.getBool('boolvalue');
    final bool? boolvalueFcaeid = prefs.getBool('faceID');

    setState(() {
      boolvalue = boolvaluecheck!;
      boolvalueFaceId = boolvalueFcaeid!;
    });
    log(boolvalue.toString());
    log(boolvalueFcaeid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: status == false ? AppColors.appThemeColor : Colors.black,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor:
            status == false ? AppColors.appThemeColor : Colors.black,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: status == false ? AppColors.textDarkColor : Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            onTap: () async {
              log(boolvalue.toString());
              if (passwordController.text.isEmpty) {
                print("in_if");
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('boolvalue', boolvalue);
                //await prefs.setString('Passcode', passwordController.text);
                await prefs.setBool('faceID', boolvalueFaceId);
                Navigator.pop(context);
              } else {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('boolvalue', boolvalue);
                await prefs.setString('Passcode', passwordController.text);
                await prefs.setBool('faceID', boolvalueFaceId);
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20.sp,
                    decoration: TextDecoration.underline,
                    fontFamily: "Hiragino Sans GB W3",
                    fontWeight: FontWeight.w600,
                    color: status == false
                        ? AppColors.textDarkColor
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
        title: text(context, "Password", 20.sp,
            boldText: FontWeight.w600,
            color: status == false ? AppColors.textDarkColor : Colors.white,
            fontFamily: "Hiragino Sans GB W3"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: status == false ? AppColors.appThemeColor : Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(0.0, 1.0), //(x,y)
                        blurRadius: 4.r,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.r)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text
                      text(context, "Lock", 20.sp,
                          boldText: FontWeight.w600,
                          color: AppColors.textDarkColor,
                          fontFamily: "Hiragino Sans GB W3"),
                      SizedBox(
                        width: 80.w,
                        height: 60.h,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: (passwordController.text.isNotEmpty &&
                                    repeatPasswordController.text.isNotEmpty &&
                                    passwordController.text ==
                                        repeatPasswordController.text)
                                ? Switch(
                                    value: boolvalue,
                                    onChanged: (val) {
                                      log(boolvalue.toString());

                                      if (passwordController.text.isNotEmpty &&
                                          repeatPasswordController
                                              .text.isNotEmpty &&
                                          passwordController.text ==
                                              repeatPasswordController.text) {
                                        setState(() {
                                          boolvalue = val;
                                          log(boolvalue.toString());
                                        });
                                      } else {
                                        ToastUtils.showCustomToast(
                                            context,
                                            "Please Check Password and Confirm Password",
                                            Colors.red);
                                      }
                                    },
                                  )
                                : boolvalue == false
                                    ? Switch(value: boolvalue, onChanged: null)
                                    : boolvalue == true
                                        ? Switch(
                                            value: boolvalue,
                                            onChanged: (val) {
                                              setState(() {
                                                boolvalue = val;
                                                log(boolvalue.toString());
                                              });
                                            },
                                          )
                                        : null),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(0.0, 1.0), //(x,y)
                        blurRadius: 4.r,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.r)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text
                      Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          text(context, "Face ID", 20.sp,
                              boldText: FontWeight.w600,
                              color: AppColors.textDarkColor,
                              fontFamily: "Hiragino Sans GB W3"),
                          SizedBox(
                            height: 5.h,
                          ),
                          text(context, "Touch ID", 20.sp,
                              boldText: FontWeight.w600,
                              color: AppColors.textDarkColor,
                              fontFamily: "Hiragino Sans GB W3"),
                        ],
                      ),
                      SizedBox(
                        width: 80.w,
                        height: 60.h,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: canCheckBiometrics == true
                                ? Switch(
                                    value: boolvalueFaceId,
                                    onChanged: (val1) {
                                      setState(() {
                                        boolvalueFaceId = val1;
                                      });
                                    })
                                : Switch(
                                    value: boolvalueFaceId, onChanged: null)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(0.0, 1.0), //(x,y)
                        blurRadius: 4.r,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.r)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text
                      text(context, "Password", 20.sp,
                          boldText: FontWeight.w600,
                          color: AppColors.textDarkColor,
                          fontFamily: "Hiragino Sans GB W3"),
                      Container(
                        width: 200.w,
                        height: 43.h,
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
                            controller: passwordController,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{4,}$');
                              if (value!.isEmpty) {
                                return ("Password cannot be Empty");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 4 Character)");
                              }

                              return null;
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textDarkColor,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400),
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              hintText: '4-digit number',
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
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(0.0, 1.0), //(x,y)
                        blurRadius: 4.r,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.r)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text
                      text(context, "Confirm\nPassword", 20.sp,
                          boldText: FontWeight.w600,
                          color: AppColors.textDarkColor,
                          fontFamily: "Hiragino Sans GB W3"),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          width: 200.w,
                          height: 43.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6,
                                color: Colors.black.withOpacity(0.25),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: repeatPasswordController,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{4,}$');
                                if (value!.isEmpty) {
                                  return ("Confirm Password cannot be Empty");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid Password(Min. 4 Character)");
                                }

                                return null;
                              },
                              onSaved: (value) {
                                repeatPasswordController.text = value!;
                              },
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textDarkColor,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w400),
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                hintText: '4-digit number',
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
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: text(context, "Password cannot be reissued.", 20.sp,
                      boldText: FontWeight.w600,
                      color: status == false ? Colors.red : Colors.white,
                      fontFamily: "Hiragino Sans GB W3"),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: text(context, "If only Lock is enabled, ", 20.sp,
                      boldText: FontWeight.w600,
                      color: status == false ? Colors.red : Colors.white,
                      fontFamily: "Hiragino Sans GB W3"),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: text(context, "you will not be able to log in", 20.sp,
                      boldText: FontWeight.w600,
                      color: status == false ? Colors.red : Colors.white,
                      fontFamily: "Hiragino Sans GB W3"),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: text(context, "if you forget your password.", 20.sp,
                      boldText: FontWeight.w600,
                      color: status == false ? Colors.red : Colors.white,
                      fontFamily: "Hiragino Sans GB W3"),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: text(context, "For security reasons, ", 20.sp,
                      boldText: FontWeight.w600,
                      color: status == false ? Colors.red : Colors.white,
                      fontFamily: "Hiragino Sans GB W3"),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: text(context, "the operation does not store ", 20.sp,
                      boldText: FontWeight.w600,
                      color: status == false ? Colors.red : Colors.white,
                      fontFamily: "Hiragino Sans GB W3"),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: text(context, "any user passwords, ", 20.sp,
                      boldText: FontWeight.w600,
                      color: status == false ? Colors.red : Colors.white,
                      fontFamily: "Hiragino Sans GB W3"),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: text(
                      context, "so please never forget your password", 20.sp,
                      boldText: FontWeight.w600,
                      color: status == false ? Colors.red : Colors.white,
                      fontFamily: "Hiragino Sans GB W3"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
