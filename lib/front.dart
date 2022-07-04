
import 'package:cart/registration.dart';
import 'package:flutter/material.dart';



class Front extends StatefulWidget {
  const Front({Key? key}) : super(key: key);

  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
    width: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(image:AssetImage('assets/img.png'),fit: BoxFit.fill),
      ),
     child:Column(
       children: [
         Container(
           alignment: Alignment.center,

           width: double.infinity,
           margin: const EdgeInsets.only(top: 225),
         child:Text("Nykaa",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,fontFamily:'GreatVibes'),)),

          Container(
            child: Text("Your Beauty Our Passion",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white,fontFamily:'GreatVibes'),
            ),
          ),
         Container(

           child: Container(
             margin:  EdgeInsets.only(top: 10,right: 20,left: 20),
             child: ElevatedButton(
               style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(Colors.redAccent[400]),

               ),


               onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => Registration()));
               },
               child: Text(

                 'Get Started',
                 style: TextStyle(
                   fontFamily: 'GreatVibes',
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
             ),
           ),
         ),


       ],

     ),
      ),


    );
  }
}
