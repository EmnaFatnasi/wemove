class Activities {
  String? id;
  String? name;
  String? description;
  String? image1;
  String? image2;
  String? createdAt;
  String? updatedAt;
  int? accessibility;
  String? deletedAt;
  List<ActivityTypes>? activityTypes;

  Activities(
      {this.id,
      this.name,
      this.description,
      this.image1,
      this.image2,
      this.createdAt,
      this.updatedAt,
      this.accessibility,
      this.deletedAt,
      this.activityTypes});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image1 = json['image_1'];
    image2 = json['image_2'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accessibility = json['accessibility'];
    deletedAt = json['deleted_at'];
    if (json['activity_types'] != null) {
      activityTypes = <ActivityTypes>[];
      json['activity_types'].forEach((v) {
        activityTypes!.add(new ActivityTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image_1'] = this.image1;
    data['image_2'] = this.image2;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['accessibility'] = this.accessibility;
    data['deleted_at'] = this.deletedAt;
    if (this.activityTypes != null) {
      data['activity_types'] =
          this.activityTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityTypes {
  String? id;
  String? label;
  String? description;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  ActivityTypes(
      {this.id,
      this.label,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  ActivityTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? activityId;
  String? activityTypeId;

  Pivot({this.activityId, this.activityTypeId});

  Pivot.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    activityTypeId = json['activity_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.activityId;
    data['activity_type_id'] = this.activityTypeId;
    return data;
  }
}
