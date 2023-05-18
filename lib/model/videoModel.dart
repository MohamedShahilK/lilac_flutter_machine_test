class VideoModel {
  String? description;
  List<String>? sources;
  String? subtitle;
  String? thumb;
  String? title;

  VideoModel(
      {this.description, this.sources, this.subtitle, this.thumb, this.title});

  VideoModel.fromJson(Map<String, dynamic> json) {
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["sources"] is List) {
      sources =
          json["sources"] == null ? null : List<String>.from(json["sources"]);
    }
    if (json["subtitle"] is String) {
      subtitle = json["subtitle"];
    }
    if (json["thumb"] is String) {
      thumb = json["thumb"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["description"] = description;
    if (sources != null) {
      data["sources"] = sources;
    }
    data["subtitle"] = subtitle;
    data["thumb"] = thumb;
    data["title"] = title;
    return data;
  }
}
