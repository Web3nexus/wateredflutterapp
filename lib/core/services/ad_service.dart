import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';
import 'dart:io';

final adServiceProvider = Provider<AdService>((ref) {
  return AdService(ref);
});

class AdService {
  final Ref _ref;
  bool _isInitialized = false;

  AdService(this._ref);

  Future<void> initialize() async {
    if (_isInitialized) return;
    if (Platform.isMacOS) {
      print('ℹ️ Ads disabled on macOS');
      return;
    }
    await MobileAds.instance.initialize();
    _isInitialized = true;
  }

  bool shouldShowAds(String screenKey) {
    final user = _ref.read(authProvider).user;
    if (user != null && user.isPremium) return false;

    final settings = _ref.read(globalSettingsNotifierProvider).asData?.value;
    if (settings == null) return false;
    if (!settings.isAdsEnabled) return false;

    final allowedScreens = settings.adsScreens ?? [];
    return allowedScreens.contains(screenKey);
  }

  String get bannerAdUnitId {
    final settings = _ref.read(globalSettingsNotifierProvider).asData?.value;
    if (Platform.isAndroid) {
      return settings?.adUnitIdAndroid ?? 'ca-app-pub-3940256099942544/6300978111'; // Test ID
    } else {
      return settings?.adUnitIdIos ?? 'ca-app-pub-3940256099942544/2934735716'; // Test ID
    }
  }
}

class AdBanner extends ConsumerStatefulWidget {
  final String screenKey;
  const AdBanner({super.key, required this.screenKey});

  @override
  ConsumerState<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends ConsumerState<AdBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  void _loadAd() {
    final adService = ref.read(adServiceProvider);
    if (!adService.shouldShowAds(widget.screenKey)) return;

    _bannerAd = BannerAd(
      adUnitId: adService.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          print('BannerAd failed to load: $err');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
