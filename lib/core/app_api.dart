class AppApi {
  static const String baseUrl = 'http://3.110.54.86';
  static const String requestAccountAccess = '$baseUrl/user/request_account_access';
  static const String addOrUpdateUser = '$baseUrl/user/add_or_update_user';
  static const String getUsers = '$baseUrl/user/get_users';
  static const String addOrUpdateAnimal = '$baseUrl/animal/add_or_update_animal';
  static const String getAllAnimals = '$baseUrl/animal/get_all_animals';
  static const String initiateSpotForAnimal = '$baseUrl/animal/initiate_spot_for_animal';
  static const String getAnimalDetails = '$baseUrl/animal/get_animal_details';
  static const String addInspectionImageToAnimal = '$baseUrl/animal/add_inspection_image_to_animal';
  static const String addDocumentToAnimal = '$baseUrl/animal/add_document_to_animal';
  static const String addSpotImageToAnimal = '$baseUrl/animal/add_spot_image_to_animal';
  static const String completeSpotForAnimal = '$baseUrl/animal/complete_spot_for_animal';
  static const String animalClaimMarkAsProcessedFromTpa = '$baseUrl/animal/animal_claim_mark_as_processed_from_tpa';
}
