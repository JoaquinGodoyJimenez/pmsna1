class CatModel {
  String? id;
  String? name;
  String? temperament;
  String? origin;
  String? description;
  String? lifeSpan;
  bool? indoor;
  bool? lap;
  int? adaptability;
  int? affectionLevel;
  int? childFriendly;
  int? dogFriendly;
  int? energyLevel;
  int? grooming;
  int? healthIssues;
  int? intelligence;
  int? sheddingLevel;
  int? socialNeeds;
  int? strangerFriendly;
  int? vocalisation;
  bool? experimental;
  bool? hairless;
  bool? natural;
  bool? rare;
  bool? rex;
  bool? suppressedTail;
  bool? shortLegs;
  bool? hypoallergenic;
  String? referenceImageId;

  CatModel({
    this.id,
    this.name,
    this.temperament,
    this.origin,
    this.description,
    this.lifeSpan,
    this.indoor,
    this.lap,
    this.adaptability,
    this.affectionLevel,
    this.childFriendly,
    this.dogFriendly,
    this.energyLevel,
    this.grooming,
    this.healthIssues,
    this.intelligence,
    this.sheddingLevel,
    this.socialNeeds,
    this.strangerFriendly,
    this.vocalisation,
    this.experimental,
    this.hairless,
    this.natural,
    this.rare,
    this.rex,
    this.suppressedTail,
    this.shortLegs,
    this.hypoallergenic,
    this.referenceImageId,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'],
      name: json['name'],
      temperament: json['temperament'],
      origin: json['origin'],
      description: json['description'],
      lifeSpan: json['life_span'],
      indoor: json['indoor'] == 1,
      lap: json['lap'] == 1,
      adaptability: json['adaptability'],
      affectionLevel: json['affection_level'],
      childFriendly: json['child_friendly'],
      dogFriendly: json['dog_friendly'],
      energyLevel: json['energy_level'],
      grooming: json['grooming'],
      healthIssues: json['health_issues'],
      intelligence: json['intelligence'],
      sheddingLevel: json['shedding_level'],
      socialNeeds: json['social_needs'],
      strangerFriendly: json['stranger_friendly'],
      vocalisation: json['vocalisation'],
      experimental: json['experimental'] == 1,
      hairless: json['hairless'] == 1,
      natural: json['natural'] == 1,
      rare: json['rare'] == 1,
      rex: json['rex'] == 1,
      suppressedTail: json['suppressed_tail'] == 1,
      shortLegs: json['short_legs'] == 1,
      hypoallergenic: json['hypoallergenic'] == 1,
      referenceImageId: json['reference_image_id'],
    );
  }
}
