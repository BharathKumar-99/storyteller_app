import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/initilizing/supabase.dart';
import 'package:storyteller/model/story_model.dart';
import 'package:storyteller/model/tags_model.dart';
import 'package:storyteller/model/user_model.dart';
import 'package:storyteller/util/routes/index.dart';

import '../../helpers/shared_preferences.dart';
import '../../supabase_calls/user.dart';
import '../../util/routes/routes_constants.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel userModel = UserModel();
  List<StoryModel> stories = [];
  List<TagsModel> tags = [];
  bool loading = true;

  getUserDetails() async {
    loading = true;
    notifyListeners();
    userModel = await SupaBaseCalls().getuserDetails();
    getUserStories();
  }

  getUserStories() async {
    await SupaFlow.client
        .from(TableConstants.stories)
        .select('*')
        .eq(TableConstants.userid, userModel.userId ?? '')
        .then((value) {
      for (Map<String, dynamic> element in value) {
        stories.add(StoryModel.fromJson(element));
      }
    });
    tags = userModel.usersTags?.map((e) => e.tags).toList().cast<TagsModel>() ??
        [];
    loading = false;
    notifyListeners();
  }

  logout() async {
    await SupaFlow.client.auth.signOut();
    SharedPreferencesUtil.clear();
    ctx!.go(RouteConstants.login);
  }

  void pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      loading = true;
      notifyListeners();
      String? pic = await SupaBaseCalls().uploadProfilePicture(
          image,
          '${userModel.userId}${Random().nextInt(5000)}',
          userModel.userId ?? "");
      await SupaFlow.client
          .from(TableConstants.users)
          .update({TableConstants.pic: pic}).eq(
              TableConstants.userid, userModel.userId ?? "");
      userModel = await SupaBaseCalls().getuserDetails();
      loading = false;
      notifyListeners();
    }
  }
}
