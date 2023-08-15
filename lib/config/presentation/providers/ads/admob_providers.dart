import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscellanous/config/config.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  //validate if the user has purchased the remove ads
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw 'Ads are disabled';

  final ad = await AdmobPlugin.loadBannerAd();

  return ad;
});

final adInterstitialProvider =
    FutureProvider.autoDispose<InterstitialAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw 'Ads are disabled';

  final ad = await AdmobPlugin.loadInterstitialAd();

  return ad;
});

final adRewardedProvider = FutureProvider.autoDispose<RewardedAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw 'Ads are disabled';

  final ad = await AdmobPlugin.loadRewardedAd();
  return ad;
});
