import 'dart:developer';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'package:lifelinekerala/view/bottom_bar/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  bool _isLoading = false;

  bool signInObscureText = true;

  void signInObscureChange() {
    setState(() {
      signInObscureText = !signInObscureText;
    });
  }

  Future<void> _attemptLogin() async {
    setState(() {
      _isLoading = true;
    });

    String username = usernameController.text;
    String password = passwordController.text;

    final loginResponse = await _apiService.login(username, password);

    setState(() {
      _isLoading = false;
    });

    if (loginResponse != null) {
      // Save credentials
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('password', password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottombarScreens(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed, please try again')),
      );
    }
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (username != null && password != null) {
      usernameController.text = username;
      passwordController.text = password;

      _attemptLogin();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            const Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'User Name',
                  prefixIcon: Icon(Icons.email_outlined),
                  suffixIcon: Icon(Icons.check_circle_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
                obscureText: signInObscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: signInObscureChange,
                    icon: Icon(
                      signInObscureText
                          ? Icons.visibility_off
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(300, 50),
                    ),
                    onPressed: _attemptLogin,
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don’t have an account? ',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                        'https://lifelinekeralatrust.com/member/auth/register');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                      log('URL opened: $url');
                    } else {
                      log('Could not launch URL');
                    }
                  },
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'By signing up, you are agree with our ',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Terms & Conditions',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
