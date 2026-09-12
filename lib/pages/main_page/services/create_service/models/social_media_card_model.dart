
class SocialMediaCardModel {
  String? icon;
  String? name;
  String? url;
  String? title;
  String? description;
  bool enabled;
  bool isFixed;

  SocialMediaCardModel({
    this.icon,
    this.name,
    this.url,
    this.title,
    this.description,
    this.enabled = false,
    this.isFixed = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'url': url,
      'description': description,
      'enabled': enabled,
    };
  }
}