import 'dart:convert';
import 'dart:typed_data';

import 'package:HAPPYPETS/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetProfileStore {
  static const _key = 'pet_profile';

  static Future<void> save(PetDataModel pet, Uint8List photo) async {
    final preferences = await SharedPreferences.getInstance();
    final data = pet.toMap();
    // Persist the photo itself; picker paths can point to temporary files.
    data['image'] = base64Encode(photo);
    if (!await preferences.setString(_key, jsonEncode(data))) {
      throw StateError('Could not save the pet profile');
    }
  }

  static Future<PetDataModel?> load() async {
    final preferences = await SharedPreferences.getInstance();
    final saved = preferences.getString(_key);
    if (saved == null) return null;
    return PetDataModel.fromMap(jsonDecode(saved) as Map<String, dynamic>);
  }
}
