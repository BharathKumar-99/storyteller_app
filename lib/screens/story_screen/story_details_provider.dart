import 'package:flutter/material.dart';
import 'package:storyteller/constants/list_constants.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/model/tags_model.dart';

import '../../initilizing/supabase.dart';
import '../../model/story_model.dart';

class StoryDetailsProvider extends ChangeNotifier {
  StoryModel story = StoryModel();
  List<TagsModel> tag = [];
  int viewCount = 0;
  bool isLoading = true;

  Future<void> getStory(int id) async {
    isLoading = true;
    notifyListeners();
    await SupaFlow.client
        .from(TableConstants.stories)
        .select('*')
        .eq(TableConstants.id, id)
        .single()
        .then((value) {
      story = StoryModel.fromJson(value);

      isLoading = false;
    });
    getViews();

    await SupaFlow.client
        .from(TableConstants.storyTags)
        .select(' ${TableConstants.tagId} ')
        .eq(TableConstants.storyid, story.id ?? 0)
        .then((value) {
      for (var element in value) {
        tag.add(TagsModel(
            id: element[TableConstants.tagId],
            name: ListConstants.tags[element[TableConstants.tagId]] ?? ""));
      }
    });

    notifyListeners();

    await Future.delayed(const Duration(seconds: 60), () => updateView());
  }

  getViews() async {
    await SupaFlow.client
        .from(TableConstants.viewTable)
        .select('*')
        .eq(TableConstants.storyid, story.id ?? 0)
        .count()
        .then((val) {
      viewCount = val.count;
    });
  }

  updateView() async {
    await SupaFlow.client
        .from(TableConstants.viewTable)
        .select('*')
        .eq(TableConstants.storyid, story.id ?? 0)
        .eq(
          TableConstants.userid,
          SupaFlow.client.auth.currentUser?.id ?? "",
        )
        .then((val) async {
      if (val.isEmpty) {
        await SupaFlow.client.from(TableConstants.viewTable).insert({
          TableConstants.userid: SupaFlow.client.auth.currentUser?.id,
          TableConstants.storyid: story.id ?? 0
        });
      }
    });
  }
}
