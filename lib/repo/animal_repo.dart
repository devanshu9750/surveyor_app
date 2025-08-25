import 'package:image_picker/image_picker.dart';
import 'package:surveyor_app/core/api_request.dart';
import 'package:surveyor_app/core/app_api.dart';
import 'package:surveyor_app/core/app_constants.dart';

class AnimalRepo {
  static final AnimalRepo _instance = AnimalRepo._internal();
  factory AnimalRepo() => _instance;
  AnimalRepo._internal();

  Future<Map<String, dynamic>> initiateSpot({required int id}) async {
    final response = await ApiRequest().postRequest(AppApi.initiateSpotForAnimal, {'id': id});

    if (response.statusCode != 200) throw Exception('Failed to initiate spot: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Failed to initiate spot: ${data['message']}');
    }

    return data['contents'];
  }

  Future<Map<String, dynamic>> addOrUpdateAnimal(Map<String, dynamic> animalData) async {
    final response = await ApiRequest().postRequest(AppApi.addOrUpdateAnimal, animalData);

    if (response.statusCode != 200) throw Exception('Animal save failed: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Animal save failed: ${data['message']}');
    }

    return data['contents'];
  }

  Future<Map<String, dynamic>> getAnimals({int page = 1, String? searchQuery, int? staffID}) async {
    final response = await ApiRequest().postRequest(AppApi.getAllAnimals, {
      'page': page,
      if (searchQuery != null) 'search_query': searchQuery,
      if (staffID != null) 'staff_id': staffID,
    });

    if (response.statusCode != 200) throw Exception('Failed to load animals: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Failed to load animals: ${data['message']}');
    }

    return data['contents'];
  }

  Future<Map<String, dynamic>> getAnimalById({required int id}) async {
    final response = await ApiRequest().postRequest(AppApi.getAnimalDetails, {'id': id});

    if (response.statusCode != 200) throw Exception('Failed to load animal: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Failed to load animal: ${data['message']}');
    }

    return data['contents'];
  }

  Future<Map<String, dynamic>> uploadInspectionImage({required int id, required XFile image}) async {
    final response = await ApiRequest().uploadFile(AppApi.addInspectionImageToAnimal, {'animal_id': id}, 'animal_doc', image);

    if (response.statusCode != 200) throw Exception('Failed to upload inspection image: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Failed to upload inspection image: ${data['message']}');
    }

    return data['contents'];
  }

  Future<Map<String, dynamic>> uploadInspectionPDF({required int id, required XFile pdf}) async {
    final response = await ApiRequest().uploadFile(AppApi.addDocumentToAnimal, {'animal_id': id}, 'animal_doc', pdf);

    if (response.statusCode != 200) throw Exception('Failed to upload inspection PDF: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Failed to upload inspection PDF: ${data['message']}');
    }

    return data['contents'];
  }
}
