import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class PetUpload {
  const PetUpload(
      {required this.name, required this.isPhoto, required this.bytes});
  final String name;
  final bool isPhoto;
  final Uint8List bytes;

  Map<String, dynamic> toMap() =>
      {'name': name, 'isPhoto': isPhoto, 'data': base64Encode(bytes)};
  factory PetUpload.fromMap(Map<String, dynamic> map) => PetUpload(
        name: map['name'] as String,
        isPhoto: map['isPhoto'] as bool,
        bytes: base64Decode(map['data'] as String),
      );
}

class PetUploadStore {
  static const _key = 'pet_uploads';
  static Future<List<PetUpload>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    return (jsonDecode(data) as List)
        .map((item) => PetUpload.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> save(List<PetUpload> uploads) async {
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.setString(
        _key, jsonEncode(uploads.map((item) => item.toMap()).toList()))) {
      throw StateError('Could not save uploads');
    }
  }
}
