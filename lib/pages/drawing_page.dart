import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled/dl_model/classifier.dart';
class DrawPage extends StatefulWidget {
  const DrawPage({Key? key}) : super(key: key);

  @override
  State<DrawPage> createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  Classifier classifier=Classifier();
  List<Offset?> points=[];
  int digit=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 10, 80, 14),
        title: Center(child: Text("Hand written Digit Recognition System",style: TextStyle(fontWeight:FontWeight.w900,fontSize: 20,color: Colors.grey.shade50),)),
        shape: RoundedRectangleBorder(
    ),
      ),
      body:Center(child:Column(
        children: [
          TextLiquidFill(
    text: 'Draw digit on Whiteboard',
    waveColor: Colors.red.shade900,
    boxBackgroundColor: Color.fromARGB(255, 182, 224, 210),
    textStyle: TextStyle(
      fontSize: 37,
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
              border: Border.all(color:  Color.fromARGB(255, 10, 80, 14),width: 5),
          ),
            child:GestureDetector(
              onPanUpdate: (DragUpdateDetails details){
                Offset localPosition=details.localPosition;
                setState(() {
                  if(localPosition.dx>=5 &&localPosition.dx<=290&&localPosition.dy>=5&&localPosition.dy<=290)
                    {
                      points.add(localPosition);
                    }

                });
              },
              onPanEnd: (DragEndDetails details) async{
                points.add(null);
                digit=await classifier.ClassifyDrawing(points);
                setState(() {

                });
              },
              child:CustomPaint(
                painter:painter(points:points),
              ),
            )
          ),
          SizedBox(height:10),
        Text(digit==-1?"loading..........":"$digit",style:TextStyle(fontFamily: 'OoohBaby',fontSize: 70,fontWeight: FontWeight.bold,color: Colors.red.shade900))
        ],
      ),
      ),
      backgroundColor: Color.fromARGB(255, 142, 150, 141),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          digit=-1;
          setState(() {

          });
          points.clear();
        },
        backgroundColor:  Color.fromARGB(255, 10, 80, 14),
        child:Icon(Icons.clear),
      ),
    );
  }
}

class painter extends CustomPainter{
  final points;
  painter({this.points});
  final Paint paintDetails=Paint()
    ..style =PaintingStyle.stroke
    ..strokeWidth=25.0
    ..color=Colors.black;


  @override
  void paint(Canvas canvas,Size size)
  {
    for(int i=0;i<points.length-1;i++) {
      if(points[i]!=null && points[i+1]!=null) {
        canvas.drawLine(points[i], points[i + 1], paintDetails);
      }
    }

  }
  @override
  bool shouldRepaint(painter oldDelegate)
  {
  return true;
  }
}

