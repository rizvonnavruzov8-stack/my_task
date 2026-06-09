import 'dart:convert';
import 'package:flutter/material.dart';

class BadUserProfileScreen extends StatefulWidget {
  const BadUserProfileScreen({super.key});

  @override
  State<BadUserProfileScreen> createState() => _BadUserProfileScreenState();
}

class _BadUserProfileScreenState extends State<BadUserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Local state variables for loading, error, and data
  bool _isLoading = false;
  bool _isSaving = false;
  String? _errorMessage;
  
  // Raw JSON parsed user data
  Map<String, dynamic>? _userData;

  // Controllers for the input fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _bioController = TextEditingController();
    _fetchUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // --- VIOLATION: API Call & JSON Parsing directly inside the UI State ---
  Future<void> _fetchUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulating a network request delay
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // Simulating getting a JSON response string from a server
      const jsonResponse = '''
      {
        "id": "123",
        "name": "Rizvon Navruzov",
        "email": "[EMAIL_ADDRESS]",
        "bio": "Student"
      }
      ''';

      // Parsing JSON directly in the UI layer
      final parsedData = json.decode(jsonResponse) as Map<String, dynamic>;
      
      setState(() {
        _userData = parsedData;
        _nameController.text = parsedData['name'] ?? '';
        _emailController.text = parsedData['email'] ?? '';
        _bioController.text = parsedData['bio'] ?? '';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load profile: $e';
        _isLoading = false;
      });
    }
  }

  // --- VIOLATION: Business/API Logic and Validation coupled with Save button handler ---
  Future<void> _saveUser() async {
    // UI Validation
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Simulating putting the fields back into JSON structure
      final updatedJson = {
        "id": _userData?['id'] ?? '123',
        "name": _nameController.text,
        "email": _emailController.text,
        "bio": _bioController.text,
      };

      // Simulating API POST request
      final jsonBody = json.encode(updatedJson);
      debugPrint('Sending payload to server: $jsonBody');
      
      await Future.delayed(const Duration(milliseconds: 1500));

      // UI/Navigation feedback coupled with network logic
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully! (Monolithic)')),
        );
      }

      setState(() {
        _userData = updatedJson;
        _isSaving = false;
      });
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile (Monolithic - Bad)'),
        backgroundColor: Colors.red.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading || _isSaving ? null : _fetchUser,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 16),
            Text('Fetching profile from API...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _fetchUser,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Retry', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    if (_userData == null) {
      return const Center(child: Text('No profile data loaded.'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- VIOLATION: Sub-widgets are defined inline, bloating the main widget ---
            const Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                // Inline validation regex
                if (!value.contains('@')) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Bio Field
            TextFormField(
              controller: _bioController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Biography',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            ElevatedButton(
              onPressed: _isSaving ? null : _saveUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Save Changes (Bloated)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
            
            const SizedBox(height: 12),
            Card(
              color: Colors.amber.shade100,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                key: ValueKey('monolithic_warning_card'),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'WARNING: This page does everything inside a single file. Adding any feature (like "Delete User") will require modifying this file, risking breaking existing code.',
                        style: TextStyle(fontSize: 12, color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
