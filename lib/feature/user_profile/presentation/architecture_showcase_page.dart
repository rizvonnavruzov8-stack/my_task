import 'package:flutter/material.dart';
import 'user_profile_page.dart';
import 'bad_user_profile_screen.dart';

class ArchitectureShowcasePage extends StatelessWidget {
  const ArchitectureShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOLID Refactoring Showcase', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Hero Banner
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade600],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: const Column(
                children: [
                  Icon(Icons.dashboard_customize_rounded, size: 64, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'SOLID Flutter Architecture',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Refactoring a monolithic profile screen into clean, decoupled, and testable components.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Implementation to Inspect:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // Side by Side Cards
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Monolithic Card
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.red.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.red.shade200, width: 1.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.red.shade50,
                                  child: Icon(Icons.warning_amber_rounded, color: Colors.red.shade700),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  '1. Monolithic Screen',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'API calls, JSON parsing, state validation, and layout are combined in a single file (~300 lines).',
                                  style: TextStyle(fontSize: 12, color: Colors.black87),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const BadUserProfileScreen()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                                    label: const Text('Open Bad UI', style: TextStyle(fontSize: 12)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      // SOLID Card
                      Expanded(
                        child: Card(
                          elevation: 6,
                          shadowColor: Colors.green.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.green.shade200, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green.shade50,
                                  child: Icon(Icons.verified_user_rounded, color: Colors.green.shade700),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  '2. SOLID Screen',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Separated into Presentation, Cubit, Repositories, data modules, and DI container. No file > 120 lines.',
                                  style: TextStyle(fontSize: 12, color: Colors.black87),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const UserProfilePage()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green.shade700,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                                    label: const Text('Open SOLID UI', style: TextStyle(fontSize: 12)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  const Text(
                    'SOLID Application Breakdown:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // S - Single Responsibility
                  _buildPrincipleTile(
                    letter: 'S',
                    title: 'Single Responsibility Principle (SRP)',
                    description: 'Divided the monolithic view into specific components: UserAvatar, UserInfoForm, SaveButton, and DeleteButton. Main page only organizes them.',
                    details: 'Files: widgets/user_avatar.dart, widgets/user_info_form.dart, widgets/action_buttons.dart. Each class has one job.',
                    icon: Icons.splitscreen_outlined,
                  ),
                  
                  // O - Open/Closed
                  _buildPrincipleTile(
                    letter: 'O',
                    title: 'Open / Closed Principle (OCP)',
                    description: 'UI and state layers work against abstract repositories. Added a "Delete User" feature without altering existing reader/writer dependencies.',
                    details: 'Result: Add code rather than rewrite. Zero risk of breaking existing features during additions.',
                    icon: Icons.lock_open_outlined,
                  ),
                  
                  // L - Liskov Substitution
                  _buildPrincipleTile(
                    letter: 'L',
                    title: 'Liskov Substitution Principle (LSP)',
                    description: 'Created UserRepositoryImpl (production API simulate) and MockUserRepository (test memory database) implementing the same repository contract.',
                    details: 'Result: We can swap the real API repository with a mock database transparently without the Cubit noticing.',
                    icon: Icons.swap_horiz_rounded,
                  ),
                  
                  // I - Interface Segregation
                  _buildPrincipleTile(
                    letter: 'I',
                    title: 'Interface Segregation Principle (ISP)',
                    description: 'Split the repository interface into independent granular roles: UserReader (get), UserWriter (save), and UserDeleter (delete).',
                    details: 'Result: No fat interfaces forcing classes to implement methods they do not need.',
                    icon: Icons.grid_view_rounded,
                  ),
                  
                  // D - Dependency Inversion
                  _buildPrincipleTile(
                    letter: 'D',
                    title: 'Dependency Inversion Principle (DIP)',
                    description: 'Cubit depends on abstract reader/writer interfaces, not concrete implementations. Dependencies are provided using a Service Locator.',
                    details: 'Result: High decoupling. We configure the locator (injection.dart) in main.dart once, then inject it.',
                    icon: Icons.account_tree_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrincipleTile({
    required String letter,
    required String title,
    required String description,
    required String details,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              radius: 24,
              child: Text(
                letter,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      details,
                      style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
