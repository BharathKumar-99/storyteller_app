class StoryModel {
  int? id;
  String? createdAt;
  String? title;
  String? pic;
  String? story;
  String? userid;
  bool? approved;
  int? views;

  StoryModel({
    this.id,
    this.createdAt,
    this.title,
    this.pic,
    this.story,
    this.userid,
    this.approved,
    this.views,
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    title = json['title'];
    pic = json['pic'];
    story = json['story'];
    userid = json['user_id'];
    approved = json['approved'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (createdAt != null) {
      data['created_at'] = createdAt;
    }
    if (title != null) {
      data['title'] = title;
    }
    if (pic != null) {
      data['pic'] = pic;
    }
    if (story != null) {
      data['story'] = story;
    }
    if (userid != null) {
      data['user_id'] = userid;
    }
    if (approved != null) {
      data['approved'] = approved;
    }
    if (views != null) {
      data['views'] = views;
    }

    return data;
  }
}
