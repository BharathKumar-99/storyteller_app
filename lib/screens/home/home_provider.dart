import 'package:flutter/material.dart';
import 'package:storyteller/constants/list_constants.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/initilizing/supabase.dart';

import '../../model/story_model.dart';
import '../../model/user_model.dart';
import '../../supabase_calls/user.dart';
import '../../util/routes/routes_constants.dart';

class HomeProvider extends ChangeNotifier {
  List<StoryModel> continuedStories = [];
  List<Map<String, List<StoryModel>>> tempStories = [];
  List<Map<String, List<StoryModel>>> stories = [];
  UserModel userModel = UserModel();
  List<int> adddedStories = [];
  bool isLoading = true;

  Future<void> getStories() async {
    try {
      userModel = await SupaBaseCalls().getuserDetails();
      continuedStories =
          userModel.continuedStoriesId?.map((e) => e.story!).toList() ?? [];

      notifyListeners();

      await SupaFlow.client.rpc(TableConstants.fetchStories, params: {
        TableConstants.fetchStoriesParam:
            userModel.usersTags?.map((e) => e.tagId).toList()
      }).then((value) async {
        value.forEach((element) {
          element[TableConstants.tagIds].forEach((tag) {
            tempStories.add({
              ListConstants.tags[tag] ?? "": [StoryModel.fromJson(element)]
            });
          });
        });
      });

      stories = mergeStoriesByTags(tempStories);
      notifyListeners();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      SupaBaseCalls().uploadError(RouteConstants.home, e.toString());
    }
  }

  List<Map<String, List<StoryModel>>> mergeStoriesByTags(
      List<Map<String, List<StoryModel>>> tempStories) {
    Map<String, List<StoryModel>> mergedMap = {};
    Set<int> addedStoryIds = {};

    for (var storyMap in tempStories) {
      storyMap.forEach((tag, storiesList) {
        if (!mergedMap.containsKey(tag)) {
          mergedMap[tag] = [];
        }
        for (var story in storiesList) {
          if (!addedStoryIds.contains(story.id)) {
            mergedMap[tag]!.add(story);
            addedStoryIds.add(story.id ?? 0);
          }
        }
      });
    }

    return mergedMap.entries.map((entry) => {entry.key: entry.value}).toList();
  }
}
