// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gtd/all%20Screen/splash%20Screen/splashScreen.dart';
import 'package:gtd/all%20Screen/widgets/textWidget.dart';
import 'package:gtd/images/appImages.dart';
import 'package:gtd/routes/appRoutes.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:local_auth/local_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingSplashScreen extends StatefulWidget {
  const StartingSplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StartingSplashScreenState createState() => _StartingSplashScreenState();
}

class _StartingSplashScreenState extends State<StartingSplashScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool didauthenticate = false;

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  String? Password;

  @override
  void initState() {
    super.initState();

    showValue();
  }

  showValue() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final bool? counter = prefs.getBool('boolvalue');
    final bool? FaceId = prefs.getBool('faceID');
    final String? password = prefs.getString('Passcode');
    setState(() {
      Password = password;
    });
    log(counter.toString());
    log(password.toString());
    log(FaceId.toString());

    if (FaceId == true) {
      _authenticateWithBiometrics();
    } else {
      if (counter != null) {
        if (counter == true) {
          _showLockScreen(
            context,
            opaque: false,
            cancelButton: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Cancel',
            ),
          );
        } else {
          jump();
        }
      } else {
        jump();
      }
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        didauthenticate = true;
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        jump();
      } else {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
    if (!mounted) {
      return;
    }
  }

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    required Widget cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
            title: const Text(
              'Enter App Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: const Text(
              'Delete',
              style: TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
            passwordDigits: 4,
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = Password == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      AppRoutes.push(context, PageTransitionType.fade, const SplashScreen());
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appThemeColor,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.appspalshImg,
                  height: 250,
                  width: 250,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: text(
                    context,
                    'THE GTD',
                    25.sp,
                    color: AppColors.textDarkColor,
                    fontFamily: "Hiragino Sans",
                    boldText: FontWeight.w700,
                  ),
                ),
              ],
            )));
  }

  jump() {
    Timer(
        const Duration(seconds: 1),
        () => AppRoutes.pushAndRemoveUntil(
            context, PageTransitionType.fade, const SplashScreen()));
  }
}
