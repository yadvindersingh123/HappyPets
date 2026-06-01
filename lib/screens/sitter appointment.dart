import 'package:HAPPYPETS/screens/payment.dart';
import 'package:flutter/material.dart';


class SitterAppointment extends StatefulWidget {
  final Map<String, dynamic> sitterDetails;
  
  const SitterAppointment({
    super.key,
    required this.sitterDetails,
  });

  @override
  State<SitterAppointment> createState() => _SitterAppointmentState();
}

class _SitterAppointmentState extends State<SitterAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Selected Sitter",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            Center(
              child: Text(
                widget.sitterDetails['name'] ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  double rating = widget.sitterDetails['rating'] ?? 0.0;
                  if (index < rating.floor()) {
                    return const Icon(Icons.star, color: Colors.amber, size: 24);
                  } else if (index == rating.floor() && rating % 1 != 0) {
                    return const Icon(Icons.star_half, color: Colors.amber, size: 24);
                  } else {
                    return const Icon(Icons.star_border, color: Colors.amber, size: 24);
                  }
                }),
              ),
            ),
            const SizedBox(height: 24),
            
            ListTile(
              leading: const Icon(Icons.work, color: Colors.blue),
              title: Text(widget.sitterDetails['experience'] ?? ''),
            ),
            
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.blue),
              title: Text(widget.sitterDetails['location'] ?? ''),
            ),
            
            const ListTile(
              leading: Icon(Icons.pets, color: Colors.blue),
              title: Text("Pet Care Specialist"),
              subtitle: Text("• Dog and Cat Care\n• Pet Sitting\n• Basic Health Check\n• Pet Training\n• Emergency Care"),
            ),
            
            const ListTile(
              leading: Icon(Icons.access_time, color: Colors.blue),
              title: Text("Working Hours"),
              subtitle: Text("Monday - Friday: 9:00 AM - 5:00 PM\nSaturday: 10:00 AM - 2:00 PM"),
            ),
            
            const SizedBox(height: 16),
            
            const Center(
              child: Text(
                "Fee: ₹500",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Payment(amount: 500),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
