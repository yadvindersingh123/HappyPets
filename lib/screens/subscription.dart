import 'package:flutter/material.dart';
import 'payment.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int _selectedPlan = 0;
  double? _selectedAmount;

  final List<Map<String, dynamic>> _plans = [
    {
      'title': 'Weekly',
      'price': '₹400',
      'desc': 'Perfect for short-term needs',
      'amount': 400.0
    },
    {
      'title': 'Monthly',
      'price': '₹1,500',
      'desc': 'Most popular choice',
      'amount': 1500.0
    },
    {
      'title': 'Yearly',
      'price': '₹15,000',
      'desc': 'Best value for money',
      'amount': 15000.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subscription Plans',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Your Plan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ..._plans.asMap().entries.map((entry) {
              int index = entry.key + 1;
              var plan = entry.value;
              return Column(
                children: [
                  _buildSubscriptionCard(
                    index,
                    plan['title'],
                    plan['price'],
                    plan['desc'],
                    plan['amount'],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
            if (_selectedAmount != null)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Payment(amount: _selectedAmount!),
                      ),
                    );
                  },
                  child: const Text('Continue'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(
      int index,
      String title,
      String price,
      String description,
      double amount,
      ) {
    bool isSelected = _selectedPlan == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = index;
          _selectedAmount = amount;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    if (isSelected)
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.check_circle, color: Colors.blue),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
