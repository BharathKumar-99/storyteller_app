import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:storyteller/constants/keys_constants.dart';

class InterstitialExampleState {
  InterstitialAd? _interstitialAd;

  /// Loads an interstitial ad.
  void loadAd(Function(InterstitialAd) onAdLoaded) {
    InterstitialAd.load(
        adUnitId: KeyConstants.interstlerAddKey,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: onAdLoaded,
                onAdClicked: (ad) {});
            debugPrint('$ad loaded.');
            _interstitialAd = ad;
            _interstitialAd!.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }
}
