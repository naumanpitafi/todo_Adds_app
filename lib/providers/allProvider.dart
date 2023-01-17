import 'package:gtd/all%20Screen/someDay/someDayMayBe.dart';
import 'package:gtd/providers/deleteProvider.dart';

import 'package:gtd/providers/nextActionProvider.dart';
import 'package:gtd/providers/projectProvider.dart';
import 'package:gtd/providers/referenceProvider.dart';
import 'package:gtd/providers/somedaymaybeProvider.dart';
import 'package:gtd/providers/themeProvider.dart';
import 'package:gtd/providers/trashProvider.dart';
import 'package:gtd/providers/waitingProvider.dart';
import 'package:provider/provider.dart';

import 'calenderProvider.dart';
import 'doitProvider.dart';
import 'inboxProvider.dart';

var allProvider = [
  ChangeNotifierProvider<DoitProvider>(
    create: (_) => DoitProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<NextActionProvider>(
    create: (_) => NextActionProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<CalenderProvider>(
    create: (_) => CalenderProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<WaitingProvider>(
    create: (_) => WaitingProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ProjectListProvider>(
    create: (_) => ProjectListProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ReferenceProvider>(
    create: (_) => ReferenceProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SomeDayMaybeProvider>(
    create: (_) => SomeDayMaybeProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<TrashProvider>(
    create: (_) => TrashProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<InboxProvider>(
    create: (_) => InboxProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<DeleteProvider>(
    create: (_) => DeleteProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<DarkThemeProvider>(
    create: (_) => DarkThemeProvider(),
    lazy: true,
  ),
];
