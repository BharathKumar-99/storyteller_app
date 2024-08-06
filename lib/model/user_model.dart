import 'package:storyteller/model/story_model.dart';
import 'package:storyteller/model/tags_model.dart';

class UserModel {
  String? userId;
  String? createdAt;
  String? name;
  String? email;
  String? pic;
  String? userName;
  List<ContinuedStoriesId>? continuedStoriesId;
  List<UsersTags>? usersTags;

  UserModel(
      {this.userId,
      this.createdAt,
      this.name,
      this.email,
      this.pic,
      this.userName,
      this.continuedStoriesId,
      this.usersTags});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    createdAt = json['created_at'];
    name = json['name'];
    email = json['email'];
    pic = json['pic'];
    userName = json['user_name'];
    if (json['continued_stories_id'] != null) {
      continuedStoriesId = <ContinuedStoriesId>[];
      json['continued_stories_id'].forEach((v) {
        continuedStoriesId!.add(ContinuedStoriesId.fromJson(v));
      });
    }
    if (json['users_tags'] != null) {
      usersTags = <UsersTags>[];
      json['users_tags'].forEach((v) {
        usersTags!.add(UsersTags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['name'] = name;
    data['email'] = email;
    data['pic'] = pic;
    data['user_name'] = userName;
    if (continuedStoriesId != null) {
      data['continued_stories_id'] =
          continuedStoriesId!.map((v) => v.toJson()).toList();
    }
    if (usersTags != null) {
      data['users_tags'] = usersTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContinuedStoriesId {
  StoryModel? story;
  int? storyId;

  ContinuedStoriesId({this.story, this.storyId});

  ContinuedStoriesId.fromJson(Map<String, dynamic> json) {
    story = json['story'] != null ? StoryModel.fromJson(json['story']) : null;
    storyId = json['story_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (story != null) {
      data['story'] = story!.toJson();
    }
    data['story_id'] = storyId;
    return data;
  }
}

class UsersTags {
  TagsModel? tags;
  int? tagId;

  UsersTags({this.tags, this.tagId});

  UsersTags.fromJson(Map<String, dynamic> json) {
    tags = json['tags'] != null ? TagsModel.fromJson(json['tags']) : null;
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tags != null) {
      data['tags'] = tags!.toJson();
    }
    data['tag_id'] = tagId;
    return data;
  }
}
