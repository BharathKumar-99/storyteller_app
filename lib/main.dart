import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:storyteller/initilizing/supabase.dart';

import 'helpers/shared_preferences.dart';
import 'initilizing/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await SharedPreferencesUtil.initialize();
  await SupaFlow.initialize().then((value) => runApp(AppProviders.build()));
}
