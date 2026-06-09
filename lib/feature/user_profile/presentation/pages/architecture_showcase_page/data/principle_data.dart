import 'package:flutter/material.dart';

/// Data model representing a SOLID principle
class Principle {
  final String letter;
  final String title;
  final String description;
  final String details;
  final IconData icon;

  const Principle({
    required this.letter,
    required this.title,
    required this.description,
    required this.details,
    required this.icon,
  });
}

/// SOLID principles data
/// This contains all the principle information used in the showcase
final List<Principle> solidPrinciples = [
  Principle(
    letter: 'S',
    title: 'Single Responsibility Principle (SRP)',
    description:
        'Divided the monolithic view into specific components: UserAvatar, UserInfoForm, SaveButton, and DeleteButton. Main page only organizes them.',
    details:
        'Files: widgets/user_avatar.dart, widgets/user_info_form.dart, widgets/action_buttons.dart. Each class has one job.',
    icon: Icons.splitscreen_outlined,
  ),
  Principle(
    letter: 'O',
    title: 'Open / Closed Principle (OCP)',
    description:
        'UI and state layers work against abstract repositories. Added a "Delete User" feature without altering existing reader/writer dependencies.',
    details:
        'Result: Add code rather than rewrite. Zero risk of breaking existing features during additions.',
    icon: Icons.lock_open_outlined,
  ),
  Principle(
    letter: 'L',
    title: 'Liskov Substitution Principle (LSP)',
    description:
        'Created UserRepositoryImpl (production API simulate) and MockUserRepository (test memory database) implementing the same repository contract.',
    details:
        'Result: We can swap the real API repository with a mock database transparently without the Cubit noticing.',
    icon: Icons.swap_horiz_rounded,
  ),
  Principle(
    letter: 'I',
    title: 'Interface Segregation Principle (ISP)',
    description:
        'Split the repository interface into independent granular roles: UserReader (get), UserWriter (save), and UserDeleter (delete).',
    details:
        'Result: No fat interfaces forcing classes to implement methods they do not need.',
    icon: Icons.grid_view_rounded,
  ),
  Principle(
    letter: 'D',
    title: 'Dependency Inversion Principle (DIP)',
    description:
        'Cubit depends on abstract reader/writer interfaces, not concrete implementations. Dependencies are provided using a Service Locator.',
    details:
        'Result: High decoupling. We configure the locator (injection.dart) in main.dart once, then inject it.',
    icon: Icons.account_tree_outlined,
  ),
];
