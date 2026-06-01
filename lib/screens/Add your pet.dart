import 'package:HAPPYPETS/screens/add%20photo.dart';
import 'package:flutter/material.dart';
import 'package:HAPPYPETS/models.dart'; // Ensure PetDataModel is imported
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddPet extends StatefulWidget {
  final PetDataModel pet; // Accept pet data model

  const AddPet({super.key, required this.pet, required String petId});

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController foodController = TextEditingController();
  final TextEditingController activityController = TextEditingController();

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
                "Add ${widget.pet.name}'s details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width * 0.04,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              
              // Dynamic form fields
              _buildFormField(
                context: context,
                question: "What is ${widget.pet.name}'s breed/species?",
                controller: breedController,
              ),
              SizedBox(height: screenSize.height * 0.02),
              
              _buildFormField(
                context: context,
                question: "What is ${widget.pet.name}'s age?",
                controller: ageController,
              ),
              SizedBox(height: screenSize.height * 0.02),
              
              _buildFormField(
                context: context,
                question: "What is ${widget.pet.name}'s favorite food?",
                controller: foodController,
              ),
              SizedBox(height: screenSize.height * 0.02),
              
              _buildFormField(
                context: context,
                question: "What is ${widget.pet.name}'s favorite activity?",
                controller: activityController,
              ),
              SizedBox(height: screenSize.height * 0.05),
              
              ElevatedButton(
                onPressed: () {
                  // Existing onPressed logic
                  widget.pet.breed = breedController.text.trim();
                  widget.pet.age = ageController.text.trim();
                  widget.pet.food = foodController.text.trim();
                  widget.pet.activity = activityController.text.trim();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPhoto(pet: widget.pet),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blue.shade50,
                  minimumSize: Size(double.infinity, screenSize.height * 0.07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required BuildContext context,
    required String question,
    required TextEditingController controller,
  }) {
    final screenSize = MediaQuery.of(context).size;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            color: Colors.red.shade300,
            fontSize: screenSize.width * 0.045,
          ),
        ),
        SizedBox(height: screenSize.height * 0.01),
        TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: screenSize.width * 0.04),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.04,
              vertical: screenSize.height * 0.015,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenSize.width * 0.02),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
