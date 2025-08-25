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
  List<InspectionImage>? inspectionImages;
  List<InspectionDocument>? inspectionDocuments;

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
    this.inspectionDocuments,
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
    List<InspectionDocument>? inspectionDocuments,
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
      inspectionDocuments: inspectionDocuments ?? animal?.inspectionDocuments,
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
      inspectionDocuments: (json['inspection_documents'] as List<dynamic>?)?.map((e) => InspectionDocument.fromJson(e)).toList(),
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

class InspectionDocument {
  final int id;
  final String url;
  final String name;
  final String uploadedAt;

  InspectionDocument({required this.id, required this.url, required this.name, required this.uploadedAt});

  factory InspectionDocument.fromJson(Map<String, dynamic> json) {
    return InspectionDocument(
      id: json['document_id'],
      url: json['document_url'],
      name: json['document_name'],
      uploadedAt: json['document_uploaded_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'document_id': id, 'document_url': url, 'document_name': name, 'document_uploaded_at': uploadedAt};
  }
}
