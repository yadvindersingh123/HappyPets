import 'package:HAPPYPETS/screens/Grooming%202.dart';
import 'package:flutter/material.dart';

class Groom1 extends StatefulWidget {
  const Groom1({super.key});

  @override
  State<Groom1> createState() => _Groom1State();
}

class _Groom1State extends State<Groom1> {
  String? selectedPetId;

  final List<Map<String, String>> pets = [
    {
      'id': '1',
      'name': 'Pet 1',
      'image': '',
    },
    {
      'id': '2',
      'name': 'Pet 2',
      'image': '',
    },
  ];

  Map<String, bool> selectedServices = {
    'Nail Cut': false,
    'Eye Ear Cleaning': false,
    'Teeth Cleaning': false,
    'Combing': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Grooming',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 2.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Pet?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: pets.isEmpty
                    ? const Center(child: Text('No pets registered'))
                    : GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    final isPetSelected = selectedPetId == pet['id'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPetId =
                          isPetSelected ? null : pet['id'];
                        });
                      },
                      child: Card(
                        elevation: isPetSelected ? 4 : 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isPetSelected
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                    child: pet['image']!.isNotEmpty
                                        ? Image.network(
                                      pet['image']!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                          ) {
                                        return _petPlaceholder();
                                      },
                                    )
                                        : _petPlaceholder(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    pet['name'] ?? 'Unnamed Pet',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            if (isPetSelected)
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 16),
              const Text(
                'List of Services',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              _buildServiceRow('Nail Cut', '\$50'),
              const SizedBox(height: 12),
              _buildServiceRow('Eye Ear Cleaning', '\$50'),
              const SizedBox(height: 12),
              _buildServiceRow('Teeth Cleaning', '\$50'),
              const SizedBox(height: 12),
              _buildServiceRow('Combing', '\$50'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPetId == null) {
                      _showMessage('Please select a pet first');
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Groom2(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _petPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(
        Icons.pets,
        size: 40,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildServiceRow(String serviceName, String price) {
    return Row(
      children: [
        Checkbox(
          value: selectedServices[serviceName],
          onChanged: (bool? value) {
            setState(() {
              selectedServices[serviceName] = value ?? false;
            });
          },
        ),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.black87,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          serviceName,
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        Text(
          price,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}