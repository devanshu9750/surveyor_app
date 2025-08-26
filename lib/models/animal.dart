class Animal {
  final int? id;
  final String? tagNumber;
  final String? ownerName;
  final String? village;
  final String? taluka;
  final String? pincode;
  final int? sumInsured;
  final DateTime? policyDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? staffId;
  final bool? isSpotInitiated;
  final bool? isSpotCompleted;
  final bool? isClaimProcessedFromTPA;
  final List<InspectionImage>? inspectionImages;
  final List<AnimalDocument>? animalDocuments;
  final List<SpotImage>? spotImages;

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
    this.inspectionImages,
    this.animalDocuments,
    this.spotImages,
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
    List<InspectionImage>? inspectionImages,
    List<AnimalDocument>? animalDocuments,
    List<SpotImage>? spotImages,
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
      inspectionImages: inspectionImages ?? animal?.inspectionImages,
      animalDocuments: animalDocuments ?? animal?.animalDocuments,
      spotImages: spotImages ?? animal?.spotImages,
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
      inspectionImages: (json['inspection_images'] as List<dynamic>?)?.map((e) => InspectionImage.fromJson(e)).toList(),
      animalDocuments: (json['animal_documents'] as List<dynamic>?)?.map((e) => AnimalDocument.fromJson(e)).toList(),
      spotImages: (json['spot_images'] as List<dynamic>?)?.map((e) => SpotImage.fromJson(e)).toList(),
    );
  }

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
      'inspection_images': inspectionImages?.map((e) => e.toJson()).toList(),
      'animal_documents': animalDocuments?.map((e) => e.toJson()).toList(),
      'spot_images': spotImages?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) => other is Animal && other.id == id;

  @override
  int get hashCode => id ?? -1;
}

class InspectionImage {
  final int id;
  final String url;
  final String name;
  final String uploadedAt;

  InspectionImage({required this.id, required this.url, required this.name, required this.uploadedAt});

  factory InspectionImage.fromJson(Map<String, dynamic> json) {
    return InspectionImage(id: json['document_id'], url: json['document_url'], name: json['document_name'], uploadedAt: json['document_uploaded_at']);
  }

  Map<String, dynamic> toJson() {
    return {'document_id': id, 'document_url': url, 'document_name': name, 'document_uploaded_at': uploadedAt};
  }
}

class AnimalDocument {
  final int id;
  final String url;
  final String name;
  final String uploadedAt;

  AnimalDocument({required this.id, required this.url, required this.name, required this.uploadedAt});

  factory AnimalDocument.fromJson(Map<String, dynamic> json) {
    return AnimalDocument(id: json['document_id'], url: json['document_url'], name: json['document_name'], uploadedAt: json['document_uploaded_at']);
  }

  Map<String, dynamic> toJson() {
    return {'document_id': id, 'document_url': url, 'document_name': name, 'document_uploaded_at': uploadedAt};
  }
}

class SpotImage {
  final int id;
  final String url;
  final String name;
  final String uploadedAt;

  SpotImage({required this.id, required this.url, required this.name, required this.uploadedAt});

  factory SpotImage.fromJson(Map<String, dynamic> json) {
    return SpotImage(id: json['document_id'], url: json['document_url'], name: json['document_name'], uploadedAt: json['document_uploaded_at']);
  }

  Map<String, dynamic> toJson() {
    return {'document_id': id, 'document_url': url, 'document_name': name, 'document_uploaded_at': uploadedAt};
  }
}
