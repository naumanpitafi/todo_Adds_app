import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gtd/all%20Screen/setting%20Screen/Password.dart';
import 'package:gtd/all%20Screen/widgets/textWidget.dart';
import 'package:gtd/main.dart';
import 'package:gtd/providers/themeProvider.dart';
import 'package:gtd/routes/appRoutes.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:gtd/utils/sharedPref.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Password.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();
  DarkThemePreference statusHandler = DarkThemePreference();
  bool status = false;
  final Uri _url1 = Uri.parse(
      'https://apps.apple.com/jp/app/persona-%E8%87%AA%E5%B7%B1%E7%B4%B9%E4%BB%8B-%E3%83%9A%E3%83%AB%E3%82%BD%E3%83%8A%E5%88%86%E6%9E%90%E3%81%AB%E4%BE%BF%E5%88%A9%E3%81%AA%E3%82%A2%E3%83%97%E3%83%AA/id1626945871');
final Uri _url2= Uri.parse(
      'https://apps.apple.com/jp/app/select-tube-%E9%81%B8%E3%82%93%E3%81%A0%E3%83%81%E3%83%A3%E3%83%B3%E3%83%8D%E3%83%AB%E3%81%AE%E5%8B%95%E7%94%BB%E3%81%A0%E3%81%91%E3%82%92%E8%A1%A8%E7%A4%BA/id1624409170');
final Uri _url3 = Uri.parse(
      'https://apps.apple.com/jp/app/%E3%81%84%E3%82%8D%E3%81%84%E3%82%8D%E6%96%87%E7%AB%A0%E3%82%B8%E3%82%A7%E3%83%8D%E3%83%AC%E3%83%BC%E3%82%BF%E3%83%BC/id1620904052');

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    changestatus();
  }

  changestatus() async {
    bool _status = await statusHandler.getTheme();
    //status = darkThemeProvider.darkTheme;
    setState(() {
      status = _status;
    });

    log(status.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Obtain shared preferences.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: status == false ? AppColors.appThemeColor : Colors.black,
      appBar: AppBar(
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
        title: Row(
          children: [
            SizedBox(
              width: 60.w,
            ),
            FaIcon(
              FontAwesomeIcons.gear,
              color: status == false ? AppColors.textDarkColor : Colors.white,
            ),
            SizedBox(
              width: 10.w,
            ),
            text(context, "Settings", 20.0,
                boldText: FontWeight.w600,
                color: status == false ? AppColors.textDarkColor : Colors.white,
                fontFamily: "Hiragino Sans GB W3"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            onTap: () {
              AppRoutes.push(
                  context, PageTransitionType.fade, const PasswordSetting());
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 70.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(0.1, 1.0), //(x,y)
                      blurRadius: 4.r,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5.r)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.lock,
                      color: AppColors.textDarkColor,
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    //Text
                    text(context, "Password", 20.sp,
                        boldText: FontWeight.w600,
                        color: AppColors.textDarkColor,
                        fontFamily: "Hiragino Sans GB W3")
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70.h,
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
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.earthAmericas,
                    color: AppColors.textDarkColor,
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  //Text
                  text(context, "Language", 20.sp,
                      boldText: FontWeight.w600,
                      color: AppColors.textDarkColor,
                      fontFamily: "Hiragino Sans GB W3")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70.h,
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
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.moon,
                    color: AppColors.textDarkColor,
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  //Text
                  text(context, "Dark Mode", 20.sp,
                      boldText: FontWeight.w600,
                      color: AppColors.textDarkColor,
                      fontFamily: "Hiragino Sans GB W3"),
                  SizedBox(
                    width: 20.w,
                  ),

                  Switch(
                    value: status,
                    onChanged: (val) async {
                      setState(() {
                        status = val;
                        //statusHandler.setDarkTheme(val);
                        darkThemeProvider.setdarkTheme(val);
                        log(status.toString());
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: text(context, "App Info", 20.sp,
                  boldText: FontWeight.w600,
                  color:
                      status == false ? AppColors.textDarkColor : Colors.white,
                  fontFamily: "Hiragino Sans GB W3"),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70.h,
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
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.user,
                    color: AppColors.textDarkColor,
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  //Text
                  text(context, "Contact", 20.sp,
                      boldText: FontWeight.w600,
                      color: AppColors.textDarkColor,
                      fontFamily: "Hiragino Sans GB W3")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(0.0, 1.0), //(x,y)
                    blurRadius: 4..r,
                  ),
                ],
                borderRadius: BorderRadius.circular(5.r)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.fileLines,
                    color: AppColors.textDarkColor,
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  //Text
                  text(context, "Term Of Use", 20.sp,
                      boldText: FontWeight.w600,
                      color: AppColors.textDarkColor,
                      fontFamily: "Hiragino Sans GB W3")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70.h,
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
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.fileLines,
                    color: AppColors.textDarkColor,
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  //Text
                  text(context, "Privacy Policy", 20.sp,
                      boldText: FontWeight.w600,
                      color: AppColors.textDarkColor,
                      fontFamily: "Hiragino Sans GB W3")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          text(context, "Other Apps", 30.0,
              boldText: FontWeight.w600,
              color: status == false ? AppColors.textDarkColor : Colors.white,
              fontFamily: "Hiragino Sans GB W3"),
          SizedBox(
            height: 10.h,
          ),

          InkWell(
            onTap: () {
              _launchUrl();
            },
            child: Container(
              color: Colors.black,
              child: ListTile(
                leading: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/appAddtwo.png")),
                title: const Text(
                  'Persona',
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: 1.5,
                ),
                trailing: const Icon(Icons.share),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '自己紹介・ペルソナ分析に便利なアプリ',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    Text(
                      'Minerva株式会社',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
                selected: true,
              ),
            ),
          ),
           InkWell(
            onTap: () {
              _launchUrl1();
            },
            child: Container(
              color: Colors.black,
              child: ListTile(
                leading: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/appAdone.png")),
                title: const Text(
                  'Select Tube',
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: 1.5,
                ),
                trailing: const Icon(Icons.share),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '選んだチャンネルの動画だけを表示！',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    Text(
                      'Minerva株式会社',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
                selected: true,
              ),
            ),
          ),
           InkWell(
            onTap: () {
              _launchUrl2();
            },
            child: Container(
              color: Colors.black,
              child: ListTile(
                leading: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/appAd.png")),
                title: const Text(
                  'いろいろ文章ジェネレーター',
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: 1.5,
                ),
                trailing: const Icon(Icons.share),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'エンターテインメント',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    Text(
                      'Minerva株式会社',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
                selected: true,
              ),
            ),
          ),
          
        ]),
      ),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(_url1)) throw 'Could not launch $_url1';
  }
  void _launchUrl1() async {
    if (!await launchUrl(_url2)) throw 'Could not launch $_url2';
  }
  void _launchUrl2() async {
    if (!await launchUrl(_url3)) throw 'Could not launch $_url3';
  }
}
