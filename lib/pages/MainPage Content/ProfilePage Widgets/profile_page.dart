import 'package:cafe/Services/FireStore%20Service/firestore_services.dart';
import 'package:cafe/pages/MainPage%20Content/ProfilePage%20Widgets/profile_card_module.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future:
            FireStore().readUserData(), // Call your asynchronous function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, show a loading indicator
            return const ProfileModulePage(name: "loading..");
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // If the Future is complete and successful, display the user data
            Map<String, dynamic> userData =
                snapshot.data ?? {}; // Default to an empty map if data is null
            return ProfileModulePage(name: userData['name']);
          }
        });
  }
}
