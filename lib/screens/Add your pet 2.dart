import 'package:HAPPYPETS/models.dart'; // Ensure PetDataModel is imported
import 'package:flutter/material.dart';
import 'Add%20your%20pet.dart';

class AddPet2 extends StatefulWidget {
  final PetDataModel pet; // Accept the pet data model
  final String petId; // Pass Firestore document ID

  const AddPet2({super.key, required this.pet, required this.petId});

  @override
  State<AddPet2> createState() => _AddPet2State();
}

class _AddPet2State extends State<AddPet2> {
  final List<String> dogBreeds = [
    'Shepherd',
    'Bulldog',
    'German Shepherd',
    'Dachshund',
  ];

  List<String> selectedBreeds = [];

  void toggleBreedSelection(String breed) {
    setState(() {
      if (selectedBreeds.contains(breed)) {
        selectedBreeds.remove(breed);
      } else {
        selectedBreeds.add(breed);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height * 0.1),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 2.0),
            ),
          ),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, 
                color: Colors.black,
                size: screenSize.width * 0.06),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Add your pet',
              style: TextStyle(
                fontSize: screenSize.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, Bolanle!",
              style: TextStyle(
                fontSize: screenSize.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenSize.height * 0.03),
            Text(
              "What is ${widget.pet.name}'s breed/species?",
              style: TextStyle(
                color: Colors.red.shade300,
                fontSize: screenSize.width * 0.045,
              ),
            ),
            SizedBox(height: screenSize.height * 0.015),
            
            // Breed Selection
            ListView.builder(
              shrinkWrap: true,
              itemCount: dogBreeds.length,
              itemBuilder: (context, index) {
                final breed = dogBreeds[index];
                bool isSelected = selectedBreeds.contains(breed);
                return GestureDetector(
                  onTap: () => toggleBreedSelection(breed),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.01
                    ),
                    padding: EdgeInsets.all(screenSize.width * 0.03),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(screenSize.width * 0.03),
                      color: isSelected ? Colors.blue.shade100 : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.check_circle : Icons.circle_outlined,
                          color: isSelected ? Colors.blue : Colors.grey,
                          size: screenSize.width * 0.06,
                        ),
                        SizedBox(width: screenSize.width * 0.02),
                        Text(
                          breed,
                          style: TextStyle(fontSize: screenSize.width * 0.04),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.03),
              child: ElevatedButton(
                onPressed: selectedBreeds.isEmpty ? null : () {
                  // Update the breed in the PetDataModel
                  final updatedPet = PetDataModel(
                    name: widget.pet.name,
                    type: widget.pet.type,
                    gender: widget.pet.gender,
                    breed: selectedBreeds.join(', '),
                    age: widget.pet.age,
                    food: widget.pet.food,
                    activity: widget.pet.activity,
                    image: '',
                  );

                  // Pass updatedPet to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPet(
                        petId: widget.petId,
                        pet: updatedPet,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blue.shade50,
                  minimumSize: Size(
                    double.infinity, 
                    screenSize.height * 0.07
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
