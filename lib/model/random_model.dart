class RandomQuote {
  String? q;
  String? a;
  String? c;
  String? h;
  String? tags;

  RandomQuote({
    this.q,
    this.a,
    this.c,
    this.h,
    this.tags,
  });

  factory RandomQuote.fromJson(Map<String, dynamic> json) => RandomQuote(
    q: json["q"],
    a: json["a"],
    c: json["c"],
    h: json["h"],
    tags: json["tags"],
  );

  Map<String, dynamic> toJson() => {
    "q": q,
    "a": a,
    "c": c,
    "h": h,
    "tags": tags,
  };
}