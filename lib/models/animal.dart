class Animal {
  int? id;
  String? tagNumber;
  String? ownerName;
  String? village;
  String? taluka;
  String? pincode;
  int? sumInsured;
  DateTime? policyDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? staffId;
  bool? isSpotInitiated;
  bool? isSpotCompleted;
  bool? isClaimProcessedFromTPA;

  Animal({
    this.id,
    this.tagNumber,
    this.ownerName,
    this.village,
    this.taluka,
    this.pincode,
    this.sumInsured,
    this.policyDate,
    this.createdAt,
    this.updatedAt,
    this.staffId,
    this.isSpotInitiated,
    this.isSpotCompleted,
    this.isClaimProcessedFromTPA,
  });

  factory Animal.copyWith(
    Animal? animal, {
    int? id,
    String? tagNumber,
    String? ownerName,
    String? village,
    String? taluka,
    String? pincode,
    int? sumInsured,
    DateTime? policyDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? staffId,
    bool? isSpotInitiated,
    bool? isSpotCompleted,
    bool? isClaimProcessedFromTPA,
  }) {
    return Animal(
      id: id ?? animal?.id,
      tagNumber: tagNumber ?? animal?.tagNumber,
      ownerName: ownerName ?? animal?.ownerName,
      village: village ?? animal?.village,
      taluka: taluka ?? animal?.taluka,
      pincode: pincode ?? animal?.pincode,
      sumInsured: sumInsured ?? animal?.sumInsured,
      policyDate: policyDate ?? animal?.policyDate,
      createdAt: createdAt ?? animal?.createdAt,
      updatedAt: updatedAt ?? animal?.updatedAt,
      staffId: staffId ?? animal?.staffId,
      isSpotInitiated: isSpotInitiated ?? animal?.isSpotInitiated,
      isSpotCompleted: isSpotCompleted ?? animal?.isSpotCompleted,
      isClaimProcessedFromTPA: isClaimProcessedFromTPA ?? animal?.isClaimProcessedFromTPA,
    );
  }

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      tagNumber: json['tag_number'],
      ownerName: json['owner_name'],
      village: json['village'],
      taluka: json['taluka'],
      pincode: json['pincode'],
      sumInsured: json['sum_insured'],
      policyDate: DateTime.parse(json['policy_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      staffId: json['staff_id'],
      isSpotInitiated: json['is_spot_initiated'] ?? false,
      isSpotCompleted: json['is_spot_completed'] ?? false,
      isClaimProcessedFromTPA: json['is_claim_processed_from_tpa'] ?? false,
    );
  }

  get species => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag_number': tagNumber,
      'owner_name': ownerName,
      'village': village,
      'taluka': taluka,
      'pincode': pincode,
      'sum_insured': sumInsured,
      'policy_date': policyDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'staff_id': staffId,
      'is_spot_initiated': isSpotInitiated,
      'is_spot_completed': isSpotCompleted,
      'is_claim_processed_from_tpa': isClaimProcessedFromTPA,
    };
  }
}
