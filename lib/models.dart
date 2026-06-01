class PetDataModel {
  final String name;
  final String type;
  final String gender;
  String breed;
  String age;
  String food;
  String activity;
  String image; // Store the image path

  PetDataModel({
    required this.name,
    required this.type,
    required this.gender,
    this.breed = '',
    this.age = '',
    this.food = '',
    this.activity = '',
    this.image = '',
  });

  // Convert the object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'gender': gender,
      'breed': breed,
      'age': age,
      'food': food,
      'activity': activity,
      'image': image,
    };
  }

  // Create an object from a Map
  factory PetDataModel.fromMap(Map<String, dynamic> map) {
    return PetDataModel(
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      gender: map['gender'] ?? '',
      breed: map['breed'] ?? '',
      age: map['age'] ?? '',
      food: map['food'] ?? '',
      activity: map['activity'] ?? '',
      image: map['image'] ?? '',
    );
  }

  // Setter for the image path (photoPath)
  set photoPath(String? path) {
    if (path != null) {
      image = path;
    }
  }

  @override
  String toString() {
    return 'PetDataModel(name: $name, type: $type, gender: $gender, breed: $breed, age: $age, food: $food, activity: $activity, image: $image)';
  }
}
