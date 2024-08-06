import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:storyteller/constants/app_constants.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/initilizing/supabase.dart';
import 'package:storyteller/model/user_model.dart';

class SupaBaseCalls {
  Future<UserModel> getuserDetails() async {
    return await SupaFlow.client
        .from(TableConstants.users)
        .select(
            '''*,continued_stories_id(story_id, story(id, title, created_at, pic, story)),users_tags(tag_id, tags(id, name))''')
        .eq(TableConstants.userid, AppConstants().userId)
        .single()
        .then((value) {
          return UserModel.fromJson(value);
        });
  }

  uploadError(String name, String error) async {
    await SupaFlow.client.from(TableConstants.analyticsTable).insert({
      TableConstants.action: "$name $error",
    });
  }

  uploadData(String name, dynamic data) async {
    await SupaFlow.client
        .from(TableConstants.debugData)
        .insert({TableConstants.name: name, TableConstants.data: data});
  }

  Future<String> uploadPicture(XFile file, String filename, int storyId) async {
    await SupaFlow.client.storage.from(TableConstants.storyBucket).upload(
          '$storyId/$filename.jpg',
          File(file.path),
        );

    String url = SupaFlow.client.storage
        .from(TableConstants.storyBucket)
        .getPublicUrl('$storyId/$filename.jpg');
    return url;
  }

  Future<String> uploadProfilePicture(
      XFile file, String filename, String userId) async {
    await SupaFlow.client.storage.from(TableConstants.userBucket).upload(
          '$userId/$filename.jpg',
          File(file.path),
        );

    String url = SupaFlow.client.storage
        .from(TableConstants.userBucket)
        .getPublicUrl('$userId/$filename.jpg');
    return url;
  }
}
