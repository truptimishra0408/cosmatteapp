
import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage('assets/img_2.png'),fit: BoxFit.fill),
        ),
        child:Column(
          children: [
            Container(
                alignment: Alignment.center,

                width: double.infinity,
                margin: const EdgeInsets.only(top: 225),
                child:Text("Welcom to",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.redAccent,fontFamily:'GreatVibes'),)),

            Container(
              child: Text("Nykaa",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.redAccent,fontFamily:'GreatVibes'),
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
                        builder: (context) => Login()));
                  },
                  child: Text(

                    'Login',
                    style: TextStyle(
                      fontFamily: 'GreatVibes',
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
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
                        builder: (context) => Signup()));
                  },
                  child: Text(

                    'SignUp',
                    style: TextStyle(
                      fontFamily: 'GreatVibes',
                      color: Colors.white,
                      fontSize: 25,
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
