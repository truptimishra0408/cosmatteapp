import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'registration.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class UserStatus {
  final bool error;
  final String message;
  final String user;

  const UserStatus({
    required this.error,
    required this.message,
    required this.user,
  });

  factory UserStatus.fromJson(Map<String, dynamic> json) {
    return UserStatus(
      error: json['error'] as bool,
      message: json['message'] as String,
      user: json['user'] as String,
    );
  }
}



class _SignupState extends State<Signup> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    void Signup(String nme,String email,String passwd,String cpasswd) async {
      print("Name $nme");
      print("Email $email");
      print("Password $passwd");
      print("Cpassword $cpasswd");


      final response = await http.post(
        Uri.parse("http://192.168.0.100/society/api/ApiSignup.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nme': nme,
          'email': email,
          'passwd': passwd,
          'cpasswd': cpasswd,




        }),
      );
      if (response.statusCode == 200) {
        print("Response is as follows $response.body");
        print(await response.body);
        final parsedJson = jsonDecode(response.body);
        final usrtom = UserStatus.fromJson(parsedJson);

        if (usrtom.error == false) {
          print(usrtom.user);
          //SharedPreferencesHelper.persistOnLogin(usrtom.user,usrtom.user);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Signup Successful"),
          ));
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Registration()));



        }
        else if (usrtom.error == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(usrtom.message),
          ));
        }
      } else {
        print(response.statusCode);
        throw Exception('Failed to get response from API');
      }
    }




    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,

          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_outlined,color: Colors.black,
                      )
                      ),

                      Text('Create An Account',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 25),),//
                    ] ),

                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),


                ),
                Container
                  (
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Full Name',

                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                ),

                Container(
                  padding: EdgeInsets.all(10),

                  child: TextField(
                    controller: fullnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container
                  (
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                ),


                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),

                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container
                  (
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                ),
                Container(

                  padding: EdgeInsets.all(10),

                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),


                      hintText: 'password',suffixIcon: Icon( Icons.visibility_off,color: Colors.grey,),

                    ),
                    controller: passwordController,
                  ),
                ),
                Container
                  (
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Confirm Password ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                ),

                Container(

                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: cpasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password ', suffixIcon: Icon( Icons.visibility_off,color: Colors.grey,),



                    ),
                  ),
                ),


                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Signup'),
                      onPressed: () {
                      //  Signup(String nme,String email,String passwd,String cpasswd)
                        Signup(fullnameController.text.toString(), emailController.text.toString(), passwordController.text.toString(), cpasswordController.text.toString());

                        print(passwordController.text);
                      },
                    )),
                Container(

                  child: Text('By Signing up you agree to our Privacy\n',


                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white),textAlign:TextAlign.center),
                ),
                Container(
                  child: Text('Policy and Term',


                      style: TextStyle(fontWeight: FontWeight.normal,color:Colors.blue,fontSize: 15),textAlign:TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Row(
                        children: [



                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                Text('OR',textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 70),
                  child: Row(
                    children: [

                      Text('Already have an account? ',style: TextStyle(color: Colors.white),),
                      Text(' Sign Up',style: TextStyle(color: Colors.blue),),

                    ],
                  ),
                ),


              ],
            ),
          ),
        )

    );
  }
}
