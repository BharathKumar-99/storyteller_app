import 'package:flutter/material.dart';
import 'package:storyteller/constants/keys_constants.dart';
import 'package:storyteller/helpers/shared_preferences.dart';
import 'package:storyteller/initilizing/supabase.dart';

class AppConstants {
  static const String appName = "Storyteller";
  static const String appVersion = "0.0.1";

  get isLoggedIn => SupaFlow.client.auth.currentUser?.id != null;
  get isTagsSelected =>
      SharedPreferencesUtil.getBool(KeyConstants.isTagsSelected);

  get userId => SupaFlow.client.auth.currentUser?.id;
  get userName =>
      SharedPreferencesUtil.getString(KeyConstants.userName) ?? "Rando";

  double getWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  double getHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
