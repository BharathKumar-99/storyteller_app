import 'package:storyteller/model/story_model.dart';

class HomeStoriesModel {
  StoryModel? storyModel;
  List<int>? tagIds;

  HomeStoriesModel({this.storyModel, this.tagIds});

  HomeStoriesModel.fromJson(Map<String, dynamic> json) {
    storyModel = StoryModel.fromJson(json['story']);
    tagIds = json['tag_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['story'] = storyModel?.toJson();
    data['tag_ids'] = tagIds;
    return data;
  }
}
