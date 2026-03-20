import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isEmailSignUp = false;
  bool _otpSent = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _verificationId;

  Future<void> _setLoading(bool value) async {
    if (!mounted) return;
    setState(() {
      _isLoading = value;
    });
  }

  void _showRoleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Your Role'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Retired Professional'),
              subtitle: const Text('Create profile and offer mentoring services'),
              onTap: () {
                Navigator.pop(context);
                context.go('/professional/setup');
              },
            ),
            ListTile(
              leading: const Icon(Icons.business_center),
              title: const Text('Client (Student / Company)'),
              subtitle: const Text('Search, compare, and book experts'),
              onTap: () {
                Navigator.pop(context);
                context.go('/client/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loginWithGoogle() async {
    try {
      await _setLoading(true);
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        await _setLoading(false);
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      await _setLoading(false);
      _showRoleDialog();
    } on FirebaseAuthException catch (e) {
      await _setLoading(false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Google sign-in failed')),
      );
    } catch (_) {
      await _setLoading(false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in failed')),
      );
    }
  }

  Future<void> _emailAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid email and password (min 6 chars).')),
      );
      return;
    }

    try {
      await _setLoading(true);
      if (_isEmailSignUp) {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
      } else {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
      await _setLoading(false);
      _showRoleDialog();
    } on FirebaseAuthException catch (e) {
      await _setLoading(false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Email authentication failed')),
      );
    }
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter phone number with country code (e.g. +91XXXXXXXXXX).')),
      );
      return;
    }

    await _setLoading(true);
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        await _setLoading(false);
        if (!mounted) return;
        _showRoleDialog();
      },
      verificationFailed: (FirebaseAuthException e) async {
        await _setLoading(false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'OTP send failed')),
        );
      },
      codeSent: (String verificationId, int? resendToken) async {
        await _setLoading(false);
        if (!mounted) return;
        setState(() {
          _verificationId = verificationId;
          _otpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> _verifyOtp() async {
    if (_verificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Send OTP first.')),
      );
      return;
    }

    final smsCode = _otpController.text.trim();
    if (smsCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter OTP code.')),
      );
      return;
    }

    try {
      await _setLoading(true);
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      await _setLoading(false);
      _showRoleDialog();
    } on FirebaseAuthException catch (e) {
      await _setLoading(false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'OTP verification failed')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
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
                  'Retired Experience Platform',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Login with Google, Email, or Phone OTP',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Continue with Google',
                  onPressed: _loginWithGoogle,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _isEmailSignUp ? 'Sign up with Email' : 'Login with Email',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomButton(
                          text: _isEmailSignUp ? 'Sign Up' : 'Login',
                          onPressed: _emailAuth,
                          isLoading: _isLoading,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isEmailSignUp = !_isEmailSignUp;
                            });
                          },
                          child: Text(
                            _isEmailSignUp
                                ? 'Already have an account? Login'
                                : 'New user? Create account',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (!_otpSent)
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number (+country code)',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  )
                else
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter OTP',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                const SizedBox(height: 12),
                CustomButton(
                  text: _otpSent ? 'Verify OTP' : 'Send OTP',
                  onPressed: _otpSent ? _verifyOtp : _sendOtp,
                  isLoading: _isLoading,
                ),
                if (_otpSent)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _otpSent = false;
                        _verificationId = null;
                        _otpController.clear();
                      });
                    },
                    child: const Text('Use different phone number'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
