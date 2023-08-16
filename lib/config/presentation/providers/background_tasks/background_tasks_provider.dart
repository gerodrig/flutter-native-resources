import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellanous/config/plugin/shared_preferences_plugin.dart';
import 'package:miscellanous/config/workmanager/callback_dispatcher.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundFetchNotifier extends StateNotifier<bool?> {
  final String processKeyName;

  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  checkCurrentStatus() async {
    state = await SharedPreferencesPlugin.getBool(processKeyName) ?? false;
  }

  toggleProcess() async {
    if (state == true) {
      deactivateProcess();
    } else {
      activateProcess();
    }
  }

  activateProcess() async {
    await Workmanager().registerPeriodicTask(processKeyName, processKeyName,
        //! This is the time that the process will be executed. 15 minutes is the minimum as per the documentation
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected),
        tag: processKeyName);

    await SharedPreferencesPlugin.setBool(processKeyName, true);
    state = true;
  }

  deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharedPreferencesPlugin.setBool(processKeyName, false);
    state = false;
  }
}

//? Set the notifier provider
final backgroundPokemonFetchProvider =
    StateNotifierProvider<BackgroundFetchNotifier, bool?>((ref) {
  return BackgroundFetchNotifier(
      processKeyName: fetchPeriodicBackgroundTaskKey);
});
