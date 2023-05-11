import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:untitled/dl_model/classifier.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Classifier classifier=Classifier();
  final picker=ImagePicker();
  late XFile image;
  int digit=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          image=(await picker.pickImage(source:ImageSource.gallery)) as XFile;
          digit= await classifier.ClasssifyImage(image);
          setState(() {
          });
        },
        backgroundColor: Color.fromARGB(255, 10, 80, 14),
        child:Icon(Icons.image),
      ),
     backgroundColor: Color.fromARGB(255, 142, 150, 141),
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 10, 80, 14),
        title: Center(child: Text("Hand written Digit Recognition System",style: TextStyle(fontWeight:FontWeight.w900,fontSize: 20,color: Colors.grey.shade50),)),
        shape: RoundedRectangleBorder(
    ),
      ),
      body:Center(child:Column(
        children: [
          
          TextLiquidFill(
    text: 'Upload image on whiteboard',
    waveColor: Colors.red.shade900,
    boxBackgroundColor: Color.fromARGB(255, 182, 224, 210),
    textStyle: TextStyle(
      color: Colors.black87,
      fontSize: 35,
      fontWeight: FontWeight.bold,
      fontFamily: 'OoohBaby',
    ),boxHeight: 120.0,),
    AnimatedTextKit(
    animatedTexts: [
      WavyAnimatedText('Handwritten_Digit_Recognizer/CNN/MNIST',textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'OoohBaby',color: Colors.red.shade900)),
    ],),
          SizedBox(height: 20,),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white,
              border: Border.all(color: Color.fromARGB(255, 10, 80, 14),width: 5),
                image: DecorationImage(
                  image:digit == -1 ? 
                  AssetImage("assets/white_background.jpg") as ImageProvider :
                  FileImage(File(image.path))
                ),
            ),

          ),

          SizedBox(height:10),
          Text(digit==-1?"loading..........":
              "$digit",style:TextStyle(fontFamily: 'OoohBaby',fontSize: 70,fontWeight: FontWeight.bold,color: Colors.red.shade900)),
        ],
      )
      )
    );
  }
}
