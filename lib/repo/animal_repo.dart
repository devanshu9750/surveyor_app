import 'package:surveyor_app/core/api_request.dart';
import 'package:surveyor_app/core/app_api.dart';
import 'package:surveyor_app/core/app_constants.dart';

class AnimalRepo {
  static final AnimalRepo _instance = AnimalRepo._internal();
  factory AnimalRepo() => _instance;
  AnimalRepo._internal();

  Future<void> addOrUpdateAnimal(Map<String, dynamic> animalData) async {
    final response = await ApiRequest().post(AppApi.addOrUpdateAnimal, animalData);

    if (response.statusCode != 200) throw Exception('Animal save failed: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Animal save failed: ${data['message']}');
    }

    return response.body;
  }
}
