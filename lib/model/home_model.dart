import 'dart:convert';

List<Quotes> quotesFromJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
  List<String>? categories;
  String? happinessImage;
  List<String>? happiness;
  String? friendshipImage;
  List<String>? friendship;
  String? motivationalImage;
  List<String>? motivational;
  String? positiveImage;
  List<String>? positive;
  String? successImage;
  List<String>? success;
  String? smileImage;
  List<String>? smile;
  String? leadershipImage;
  List<String>? leadership;

  Quotes({
    this.categories,
    this.happinessImage,
    this.happiness,
    this.friendshipImage,
    this.friendship,
    this.motivationalImage,
    this.motivational,
    this.positiveImage,
    this.positive,
    this.successImage,
    this.success,
    this.smileImage,
    this.smile,
    this.leadershipImage,
    this.leadership,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
    categories: json["categories"] == null
        ? []
        : List<String>.from(json["categories"].map((x) => x)),
    happinessImage: json["Happiness_image"],
    happiness: json["Happiness"] == null
        ? []
        : List<String>.from(json["Happiness"].map((x) => x)),
    friendshipImage: json["Friendship_image"],
    friendship: json["Friendship"] == null
        ? []
        : List<String>.from(json["Friendship"].map((x) => x)),
    motivationalImage: json["Motivational_image"],
    motivational: json["Motivational"] == null
        ? []
        : List<String>.from(json["Motivational"].map((x) => x)),
    positiveImage: json["Positive_image"],
    positive: json["Positive"] == null
        ? []
        : List<String>.from(json["Positive"].map((x) => x)),
    successImage: json["Success_image"],
    success: json["Success"] == null
        ? []
        : List<String>.from(json["Success"].map((x) => x)),
    smileImage: json["Smile_image"],
    smile: json["Smile"] == null
        ? []
        : List<String>.from(json["Smile"].map((x) => x)),
    leadershipImage: json["Leadership_image"],
    leadership: json["Leadership"] == null
        ? []
        : List<String>.from(json["Leadership"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x)),
    "Happiness_image": happinessImage,
    "Happiness": happiness == null
        ? []
        : List<dynamic>.from(happiness!.map((x) => x)),
    "Friendship_image": friendshipImage,
    "Friendship": friendship == null
        ? []
        : List<dynamic>.from(friendship!.map((x) => x)),
    "Motivational_image": motivationalImage,
    "Motivational": motivational == null
        ? []
        : List<dynamic>.from(motivational!.map((x) => x)),
    "Positive_image": positiveImage,
    "Positive": positive == null
        ? []
        : List<dynamic>.from(positive!.map((x) => x)),
    "Success_image": successImage,
    "Success": success == null
        ? []
        : List<dynamic>.from(success!.map((x) => x)),
    "Smile_image": smileImage,
    "Smile": smile == null
        ? []
        : List<dynamic>.from(smile!.map((x) => x)),
    "Leadership_image": leadershipImage,
    "Leadership": leadership == null
        ? []
        : List<dynamic>.from(leadership!.map((x) => x)),
  };
}
