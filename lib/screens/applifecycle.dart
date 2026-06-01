import 'package:flutter/material.dart';
class Yaad extends StatefulWidget {
  const Yaad({super.key});

  @override
  State<Yaad> createState() => _MyAppState();
}

class _MyAppState extends State<Yaad> with WidgetsBindingObserver {
  @override
  void initState() {
  super.initState();
  WidgetsBinding.instance.addObserver(this);
}

@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.name);
}
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text(
            "Home Screen",
            style: TextStyle(
              fontSize: screenSize.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: screenSize.height * 0.08,
          elevation: 4,
        ),
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          padding: EdgeInsets.all(screenSize.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }
}



