import 'package:flutter/material.dart';
import 'package:untitled/pages/drawing_page.dart';
import 'package:untitled/pages/upload_page.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex=0;
  List tabs=[
    DrawPage(),
    UploadImage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body:tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        currentIndex:currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedItemColor: Color.fromARGB(255, 10, 80, 14),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.draw),
              label:"Draw"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.image),
          label:"Image"
          ),
        ],
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
      ),
    );
  }
}

