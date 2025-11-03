import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          Image.asset('asset/Mine.jpg',
            height: 300,
            width: 300,
          ),
          SizedBox(
            height: 5,
          ),
          Text('Login With User Name and Password',
          style: TextStyle(
            color: Colors.white
          ),
          ),
          SizedBox(
            height: 10,
          ),

          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('User Id',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'User Id',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
