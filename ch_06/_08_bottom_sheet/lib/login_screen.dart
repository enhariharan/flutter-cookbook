import 'dart:developer';

import 'stop_watch.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name = '';
  String email = '';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _enterNameControl(),
            _enterEmailControl(),
            const SizedBox(height: 20),
            _enterContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _enterNameControl() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        hintText: 'Enter the runner\'s name',
        labelText: 'Runner',
      ),
      validator: (text) {
        return text!.isEmpty ? 'Enter runner name' : null;
      },
    );
  }

  Widget _enterEmailControl() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'Enter the runner\'s email',
        labelText: 'Email',
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return 'Enter the runner\'s email';
        }
        final regex = RegExp('[^@]+@[^.]+..+');
        if (!regex.hasMatch(text)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _enterContinueButton() {
    return ElevatedButton(onPressed: _validate, child: const Text('Continue'));
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!(form?.validate() ?? false)) {
      return;
    }
    final name = _nameController.text;
    final email = _emailController.text;
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => MyStopWatch(name: name, email: email),
      ),
    );
  }
}
