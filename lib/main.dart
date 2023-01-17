import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtd/all%20Screen/splash%20Screen/startingSplash.dart';
import 'package:gtd/models/categoryModel.dart';
import 'package:gtd/models/deleteModel.dart';
import 'package:gtd/models/inboxModel.dart';
import 'package:gtd/models/toDoModel.dart';
import 'package:provider/provider.dart';
import 'Hive Crud Operation/hiveCRDOperation.dart';
import 'all Screen/splash Screen/splashScreen.dart';
import 'providers/allProvider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ['1D77252964B8E499A5408D355582D85D']));
  MobileAds.instance.initialize();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(DeleteModelAdapter());
  Hive.registerAdapter(InboxModelAdapter());
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'TODO Application',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, _) {
        return MultiProvider(
          providers: allProvider,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            home: const StartingSplashScreen(),
            // home: const HiveCRUDTest(),
          ),
        );
      },
    );
  }
}
