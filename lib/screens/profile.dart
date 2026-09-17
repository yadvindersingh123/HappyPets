import 'package:HAPPYPETS/widgets/pet_bottom_navigation.dart';
import 'dart:convert';

import 'package:HAPPYPETS/models.dart';
import 'package:HAPPYPETS/services/pet_profile_store.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<PetDataModel?> _profile;

  @override
  void initState() {
    super.initState();
    _profile = PetProfileStore.load();
  }

  Widget _photo(PetDataModel pet) {
    const placeholder = ColoredBox(
      color: Color(0xFFE3F2FD),
      child: Center(child: Icon(Icons.pets, size: 72, color: Colors.blue)),
    );
    if (pet.image.isEmpty) return placeholder;
    try {
      return Image.memory(
        base64Decode(pet.image),
        fit: BoxFit.cover,
        semanticLabel: '${pet.name} photo',
        errorBuilder: (_, __, ___) => placeholder,
      );
    } on FormatException {
      return placeholder;
    }
  }

  Widget _detail(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(label,
          style: const TextStyle(fontSize: 13, color: Colors.black54)),
      subtitle: Text(
        value.trim().isEmpty ? 'Not provided' : value,
        style: const TextStyle(fontSize: 17, color: Colors.black87),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      appBar: AppBar(title: const Text('Pet Profile'), centerTitle: true),
      bottomNavigationBar: const PetBottomNavigation(currentIndex: 3),
      body: FutureBuilder<PetDataModel?>(
        future: _profile,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Could not load your pet profile.'),
                  TextButton(
                    onPressed: () =>
                        setState(() => _profile = PetProfileStore.load()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final pet = snapshot.data;
          if (pet == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                    'No pet profile yet. Complete pet setup to see your pet here.',
                    textAlign: TextAlign.center),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: SizedBox(
                            width: 180, height: 180, child: _photo(pet)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(pet.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(pet.type,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, color: Colors.blue.shade700)),
                    const SizedBox(height: 24),
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          _detail('Pet name', pet.name, Icons.badge_outlined),
                          _detail('Pet type', pet.type, Icons.pets),
                          _detail('Age', pet.age, Icons.cake_outlined),
                          _detail('Favourite activity', pet.activity,
                              Icons.sports_tennis),
                          _detail('Favourite food', pet.food, Icons.restaurant),
                          _detail('Breed / species', pet.breed,
                              Icons.category_outlined),
                          _detail('Gender', pet.gender, Icons.info_outline),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
