import 'package:flutter/material.dart';
import 'package:HAPPYPETS/screens/social meadia.dart';
import 'package:HAPPYPETS/screens/home.dart';
import 'package:HAPPYPETS/screens/profile.dart';
import 'package:HAPPYPETS/screens/uploads.dart';

class PetBottomNavigation extends StatelessWidget {
  const PetBottomNavigation({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black54,
      onTap: (index) {
        if (index == currentIndex) return;
        final pages = <Widget>[
          const Social(),
          const UploadsScreen(),
          const Home(),
          const ProfileScreen(),
        ];
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => pages[index]),
        );
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: 'Upload'),
        BottomNavigationBarItem(
            icon: Icon(Icons.design_services_outlined), label: 'Services'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
      ],
    );
  }
}
