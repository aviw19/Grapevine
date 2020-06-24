import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.text,
    this.intents,
    this.entities,
    this.traits,
  });

  String text;
  List<Intent> intents;
  Entities entities;
  Entities traits;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    text: json["text"],
    intents: List<Intent>.from(json["intents"].map((x) => Intent.fromJson(x))),
    entities: Entities.fromJson(json["entities"]),
    traits: Entities.fromJson(json["traits"]),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "intents": List<dynamic>.from(intents.map((x) => x.toJson())),
    "entities": entities.toJson(),
    "traits": traits.toJson(),
  };
}

class Entities {
  Entities();

  factory Entities.fromJson(Map<String, dynamic> json) => Entities(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Intent {
  Intent({
    this.id,
    this.name,
    this.confidence,
  });

  String id;
  String name;
  double confidence;

  factory Intent.fromJson(Map<String, dynamic> json) => Intent(
    id: json["id"],
    name: json["name"],
    confidence: json["confidence"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "confidence": confidence,
  };
}
