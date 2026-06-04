import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart' as di;
import '../cubit/user_profile_cubit.dart';
import '../cubit/user_profile_state.dart';
import '../data/user_model.dart';
import 'widgets/action_buttons.dart';
import 'widgets/user_avatar.dart';
import 'widgets/user_info_form.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(
        reader: di.sl(),
        writer: di.sl(),
        deleter: di.sl(),
      )..loadUser(),
      child: const UserProfileView(),
    );
  }
}

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _onSavePressed(BuildContext context, User currentUser) {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedUser = User(
        id: currentUser.id,
        name: _nameController.text,
        email: _emailController.text,
        bio: _bioController.text,
      );
      context.read<UserProfileCubit>().saveUser(updatedUser);
    }
  }

  void _onDeletePressed(BuildContext context, String userId) {
    context.read<UserProfileCubit>().deleteUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile (SOLID)'),
      ),
      body: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is UserProfileSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User saved successfully')),
            );
          } else if (state is UserProfileDeleted) {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User deleted successfully')),
            );
          }
        },
        builder: (context, state) {
          if (state is UserProfileInitial || state is UserProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserProfileDeleted) {
             return const Center(child: Text("User has been deleted."));
          }

          User? currentUser;
          bool isSaving = state is UserProfileSaving;
          bool isDeleting = state is UserProfileDeleting;

          if (state is UserProfileLoaded) {
            currentUser = state.user;
            // Only update text controllers if they are empty to avoid resetting cursor position
            if (_nameController.text.isEmpty) {
              _nameController.text = currentUser.name;
              _emailController.text = currentUser.email;
              _bioController.text = currentUser.bio;
            }
          }

          if (currentUser == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<UserProfileCubit>().loadUser(),
                child: const Text('Retry'),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const UserAvatar(),
                const SizedBox(height: 24),
                UserInfoForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  bioController: _bioController,
                ),
                const SizedBox(height: 24),
                SaveButton(
                  onPressed: () => _onSavePressed(context, currentUser!),
                  isLoading: isSaving,
                ),
                const SizedBox(height: 12),
                DeleteButton(
                  onPressed: () => _onDeletePressed(context, currentUser!.id),
                  isLoading: isDeleting,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
