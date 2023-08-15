import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellanous/config/config.dart';

const storedKey = 'showAds';

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(false) {
    checkAdsState();
  }

  void checkAdsState() async {
    state = await SharedPreferencesPlugin.getBool(storedKey) ?? true;
  }

  void removeAds() {
    SharedPreferencesPlugin.setBool(storedKey, false);
    state = false;
  }

  void showAds() {
    SharedPreferencesPlugin.setBool(storedKey, true);
    state = true;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }
}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});
