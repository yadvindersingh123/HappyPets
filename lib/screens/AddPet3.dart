import 'package:HAPPYPETS/models.dart'; // Ensure PetDataModel is correctly imported
import 'package:HAPPYPETS/screens/Add%20your%20pet%202.dart';
import 'package:HAPPYPETS/screens/Add%20your%20pet.dart';
import 'package:flutter/material.dart';

class Addpet3 extends StatefulWidget {
  const Addpet3({super.key});

  @override
  State<Addpet3> createState() => _Addpet3State();
}

class _Addpet3State extends State<Addpet3> {
  String? selectedPet; // Track selected pet
  String? selectedGender; // Track selected gender

  TextEditingController petNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenSize.height * 0.1),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black, width: screenSize.width * 0.005),
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
                "Welcome,",
                style: TextStyle(
                  fontSize: screenSize.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              Text(
                "What is your Pet's name?",
                style: TextStyle(
                  color: Colors.red.shade300,
                  fontSize: screenSize.width * 0.045,
                ),
              ),
              TextField(
                controller: petNameController,
                style: TextStyle(fontSize: screenSize.width * 0.04),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.height * 0.015,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Text(
                "What pet do you have?",
                style: TextStyle(
                  color: Colors.red.shade300,
                  fontSize: screenSize.width * 0.045,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: screenSize.width * 0.02,
                  mainAxisSpacing: screenSize.height * 0.02,
                  childAspectRatio: 0.8,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  List<Map<String, String>> pets = [
                    {'name': 'Dog', 'image': 'assets/dog.jpeg'},
                    {'name': 'Cat', 'image': 'assets/cat.jpg'},
                    {'name': 'Fish', 'image': 'assets/fish.jpeg'},
                    {'name': 'Bird', 'image': 'assets/bird.jpg'},
                    {'name': 'Horse', 'image': 'assets/horse.jpg'},
                    {'name': 'Others', 'image': 'assets/others.png'},
                  ];

                  bool isSelected = selectedPet == pets[index]['name'];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPet = pets[index]['name'];
                          });
                        },
                        child: Container(
                          height: screenSize.width * 0.2,
                          width: screenSize.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenSize.width * 0.03),
                            color: isSelected ? Colors.blue.shade100 : Colors.grey.shade200,
                            image: DecorationImage(
                              image: AssetImage(pets[index]['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedPet = pets[index]['name'];
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: isSelected ? Colors.blue.shade100 : Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.02,
                            vertical: screenSize.height * 0.005,
                          ),
                        ),
                        child: Text(
                          pets[index]['name']!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.035,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: screenSize.height * 0.02),
              Text(
                "What is your pet's gender?",
                style: TextStyle(
                  color: Colors.red.shade300,
                  fontSize: screenSize.width * 0.045,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildGenderOption('Male', Icons.male),
                  _buildGenderOption('Female', Icons.female),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.05),
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPet == null || selectedGender == null || petNameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields before proceeding'),
                        ),
                      );
                      return;
                    }

                    final pet = PetDataModel(
                      name: petNameController.text.trim(),
                      type: selectedPet!,
                      gender: selectedGender!,
                      breed: '',
                      age: '',
                      food: '',
                      activity: '',
                      image: '',
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPet(
                          pet: pet, petId: '',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.blue.shade50,
                    minimumSize: Size(double.infinity, screenSize.height * 0.07),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenSize.width * 0.08),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: screenSize.width * 0.04),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: selectedGender == gender ? Colors.blue : Colors.black,
            size: screenSize.width * 0.12,
          ),
          Text(
            gender,
            style: TextStyle(
              color: selectedGender == gender ? Colors.blue : Colors.black,
              fontSize: screenSize.width * 0.04,
            ),
          ),
        ],
      ),
    );
  }
}
