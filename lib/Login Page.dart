import 'package:flutter/material.dart';
import 'ToDo_List.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});


  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+={}\[\]|:;"<>,.?/~`]).{10,}$',
  );


  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


  void _login(BuildContext context) {
    String userId = _userIdController.text;
    String password = _passwordController.text;


    if (userId.isEmpty || password.isEmpty) {
      _showSnackBar(context, 'User ID or Password cannot be empty.', Colors.red);
      return;
    }


    if (!_passwordRegExp.hasMatch(password)) {
      String errorMessage = 'Password is weak! It must contain:\n'
          '- At least 10 characters\n'
          '- At least 1 Uppercase letter (A-Z)\n'
          '- At least 1 Lowercase letter (a-z)\n'
          '- At least 1 Number (0-9)\n'
          '- At least 1 Special character (!@#\$%^...)';

      _showSnackBar(context, errorMessage, Colors.yellow.shade700);
      return;
    }


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade700,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage('asset/Mine.jpg'),
                backgroundColor: Colors.teal.shade900,
              ),

              const SizedBox(height: 30),


              TextField(
                controller: _userIdController,
                decoration: InputDecoration(
                  labelText: 'Enter your User ID',
                  labelStyle: const TextStyle(color: Colors.white70),
                  fillColor: Colors.teal.shade500,
                  filled: true,
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 20),


              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter your Password',
                  labelStyle: const TextStyle(color: Colors.white70),
                  fillColor: Colors.teal.shade500,
                  filled: true,
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 30),


              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}