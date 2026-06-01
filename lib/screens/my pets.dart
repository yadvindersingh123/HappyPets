import 'package:flutter/material.dart';
import 'package:HAPPYPETS/models.dart';

class MyPets extends StatefulWidget {
  const MyPets({super.key});

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  final List<PetDataModel> pets = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Pets',
          style: TextStyle(fontSize: screenSize.width * 0.05),
        ),
        centerTitle: true,
      ),
      body: pets.isEmpty
          ? Center(
        child: Text(
          'No pets found.',
          style: TextStyle(fontSize: screenSize.width * 0.04),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(screenSize.width * 0.02),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];

          return Card(
            margin: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: screenSize.width * 0.05,
                    backgroundImage: pet.image.isNotEmpty
                        ? NetworkImage(pet.image)
                        : null,
                    child: pet.image.isEmpty
                        ? const Icon(Icons.pets)
                        : null,
                  ),
                  title: Text(
                    pet.name,
                    style: TextStyle(fontSize: screenSize.width * 0.045),
                  ),
                  subtitle: Text(
                    '${pet.breed} | ${pet.type}',
                    style: TextStyle(fontSize: screenSize.width * 0.035),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.height * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Age: ${pet.age} years',
                        style: TextStyle(fontSize: screenSize.width * 0.04),
                      ),
                      Text(
                        'Gender: ${pet.gender}',
                        style: TextStyle(fontSize: screenSize.width * 0.04),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      ElevatedButton(
                        onPressed: () => _showPetDetails(context, pet),
                        child: Text(
                          'View Details',
                          style: TextStyle(fontSize: screenSize.width * 0.04),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showPetDetails(BuildContext context, PetDataModel pet) {
    final screenSize = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '${pet.name} Details',
            style: TextStyle(fontSize: screenSize.width * 0.05),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailText('Breed', pet.breed, screenSize),
              _buildDetailText('Age', '${pet.age} years', screenSize),
              _buildDetailText('Gender', pet.gender, screenSize),
              _buildDetailText('Type', pet.type, screenSize),
              _buildDetailText('Activity', pet.activity, screenSize),
              _buildDetailText('Food', pet.food, screenSize),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(fontSize: screenSize.width * 0.04),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailText(String label, String value, Size screenSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
      child: Text(
        '$label: $value',
        style: TextStyle(fontSize: screenSize.width * 0.04),
      ),
    );
  }
}