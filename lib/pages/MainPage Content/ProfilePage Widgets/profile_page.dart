import 'package:cafe/Services/FireAuth%20Service/authentication.dart';
import 'package:cafe/Services/FireStore%20Service/firestore_services.dart';
import 'package:cafe/pages/MainPage%20Content/ProfilePage%20Widgets/profile_card_module.dart';
import 'package:flutter/material.dart';

import '../../SplashPage/splash_page.dart';

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
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // If the Future is complete and successful, display the user data
            Map<String, dynamic> userData =
                snapshot.data ?? {}; // Default to an empty map if data is null
            return Column(
              children: [
                ProfileModulePage(name: userData['name']),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30, top: 20),
                    child: OutlinedButton(
                      onPressed: () {
                        Authenticate.sign_out();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signed Out!'),
                            duration: Duration(
                                seconds: 3), // Adjust the duration as needed
                          ),
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SplashPage()));
                      },
                      child: const Text(
                        "Log out",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
