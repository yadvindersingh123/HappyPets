import 'package:HAPPYPETS/screens/Grppming%201.dart';
import 'package:flutter/material.dart';
import 'package:HAPPYPETS/screens/veterinary.dart';
import 'package:HAPPYPETS/screens/social meadia.dart';
import 'package:HAPPYPETS/screens/pet sitter.dart';
import 'package:HAPPYPETS/screens/Pet Store.dart'; // Add this import

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selecteditems;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Social()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: screenSize.height * 0.08,
          leading: IconButton(
            icon: Icon(Icons.menu, 
              color: Colors.black,
              size: screenSize.width * 0.07),
            padding: EdgeInsets.all(screenSize.width * 0.02),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Text(
            "Happy Pets",
            style: TextStyle(
              color: Colors.red.shade300,
              fontSize: screenSize.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.all(screenSize.width * 0.02),
              onPressed: () {},
              icon: Icon(Icons.notifications, 
                color: Colors.black,
                size: screenSize.width * 0.07),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.02
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: screenSize.width * 0.04,
              mainAxisSpacing: screenSize.height * 0.03,
              childAspectRatio: 0.85,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              final List<Map<String, String>> items = [
                {'name': 'Ventilatory Doctor', 'image': 'assets/doctor.jpg'},
                {'name': 'Blog', 'image': 'assets/blog.png'},
                {'name': 'Grooming', 'image': 'assets/grooming.jpg'},
                {'name': 'Pet Store', 'image': 'assets/pet store.jpg'},
                {'name': 'Pet Trainer', 'image': 'assets/pet trainer.jpg'},
                {'name': 'Services', 'image': 'assets/services.jpg'},
              ];

              bool isSelected = selecteditems == items[index]['name'];

              return Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selecteditems = items[index]['name'];
                        });
                        // Add navigation for different sections
                        if (items[index]['name'] == 'Grooming') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Groom1()),
                          );
                        } else if (items[index]['name'] == 'Ventilatory Doctor') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Veter()),
                          );
                        } else if (items[index]['name'] == 'Services') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PetSitter()),
                          );
                        } else if (items[index]['name'] == 'Pet Store') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PetStore()),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                          color: isSelected ? Colors.blue.shade100 : Colors.grey.shade200,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(items[index]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selecteditems = items[index]['name'];
                      });
                      // Add navigation for different sections
                      if (items[index]['name'] == 'Grooming') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Groom1()),
                        );
                      } else if (items[index]['name'] == 'Ventilatory Doctor') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Veter()),
                        );
                      } else if (items[index]['name'] == 'Services') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PetSitter()),
                        );
                      } else if (items[index]['name'] == 'Pet Store') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PetStore()),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: isSelected ? Colors.blue.shade100 : Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.03,
                        vertical: screenSize.height * 0.008,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenSize.width * 0.02),
                      ),
                    ),
                    child: Text(
                      items[index]['name']!,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            selectedFontSize: screenSize.width * 0.035,
            unselectedFontSize: screenSize.width * 0.03,
            iconSize: screenSize.width * 0.07,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home,
                color: Colors.black,
                ),
                label: 'Home' ,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,
                  color: Colors.black,),
                label: 'Search',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.camera,
              //     color: Colors.black,),
              //   label: 'Photo',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.upload_file,
                  color: Colors.black,),
                label: 'Upload',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.design_services,
                  color: Colors.black,),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,
                  color: Colors.black,),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
