class TagsModel {
  int? id;
  String? createdAt;
  String? name;
  String? image;

  TagsModel({this.id, this.createdAt, this.name, this.image});

  TagsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
