import 'dart:convert';

import 'package:cart/registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Login extends StatefulWidget {
  const Login ({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
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


class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    print("Email $email");
    print("Password $password");
    final response = await http.post(
      Uri.parse("http://192.168.0.102/society/api/Apiadminlogin.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email_id': email,
        'passwd': password

      }),
    );
    if (response.statusCode == 200) {
      print("Response is as follows $response.body");
      print(await response);
      final parsedJson = jsonDecode(response.body);
      final usrtom = UserStatus.fromJson(parsedJson);

      if (usrtom.error == false) {
        print(usrtom.user);
        //SharedPreferencesHelper.persistOnLogin(usrtom.user,usrtom.user);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login Successful"),
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(

                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              obscureText: false,
              controller: passwordController,
              decoration: InputDecoration(

                  hintText: 'Password'
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){

                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Login'),),
              ),
            )
          ],
        ),
      ),
    );
  }




}
