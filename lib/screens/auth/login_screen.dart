import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _otpSent = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void _sendOtp() {
    if (_phoneController.text.isNotEmpty) {
      setState(() {
        _otpSent = true;
      });
    }
  }

  void _verifyOtp() {
    // In a real app we'd authenticate. Here we just mock routing based on user type.
    // Let's show a simple dialog to pick role for testing purposes.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Role (Mock)"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Retired Professional"),
              onTap: () {
                Navigator.pop(context);
                context.go('/user/dashboard');
              },
            ),
            ListTile(
              title: const Text("Recruitment Client"),
              onTap: () {
                Navigator.pop(context);
                context.go('/client/dashboard');
              },
            ),
            ListTile(
              title: const Text("Admin"),
              onTap: () {
                Navigator.pop(context);
                context.go('/admin/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retired Professionals'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your phone number to login or sign up',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (!_otpSent) ...[
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Send OTP',
                    onPressed: _sendOtp,
                  ),
                ] else ...[
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter OTP (Mock: 1234)',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Verify & Login',
                    onPressed: _verifyOtp,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _otpSent = false;
                      });
                    },
                    child: const Text('Change Phone Number'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
