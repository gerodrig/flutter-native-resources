import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellanous/config/config.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  //? set the orientation to portrait only
  WidgetsFlutterBinding.ensureInitialized();
  //? initialize the admob plugin
  await AdmobPlugin.initialize();

  //?setup quick Actions
  QuickActionsPlugin.registerActions();

  //initialize the workmanager
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  //initializedtask
  // Workmanager().registerOneOffTask(
  //   "com.gerar.ca.miscellaneous.simpleTask",
  //   "com.gerar.ca.miscellaneous.simpleTask",
  //   inputData: <String, dynamic>{
  //     'int': 1,
  //     'bool': true,
  //     'double': 1.0,
  //     'string': 'string',
  //     'array': [1, 2, 3],
  //   },
  //   constraints: Constraints(networkType: NetworkType.connected),
  // );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print('state: $state');
    ref.read(appStateProvider.notifier).state = state;

    //? when app is resumed change the state of the permissions
    if (state == AppLifecycleState.resumed) {
      ref.read(permissionsProvider.notifier).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
