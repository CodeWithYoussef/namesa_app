import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/auth%20provider/auth_provider.dart';
import 'package:namesa_yassin_preoject/auth%20screens/auth_screen.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../../admin screens/admin_screen.dart';

class ProfileTab extends StatelessWidget {
  static const String routeName = "profile tab";

  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName =
        user?.displayName ?? user?.email?.split('@').first.trim() ?? "Guest";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text("Profile", style: Theme.of(context).textTheme.bodyLarge),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white, height: 2),
        ),
      ),
      body: Consumer<HotelRooms>(
        builder:
            (context, value, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 320,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      children: [
                        // User Name
                        Positioned(
                          top: 32,
                          left: 16,
                          child: Container(
                            width: 250,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                userName,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // Reserved Rooms Count
                        Positioned(
                          top: 100,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Rooms Reserved: ${value.reservedRooms.length}",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // Reserved Restaurants Count
                        Positioned(
                          top: 170,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Restaurants Reserved: ${value.reservedRestaurants.length}",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // Reserved Events Count
                        Positioned(
                          top: 240,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Events Reserved: ${value.reservedEvents.length}",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Divider(height: 2, color: Colors.white, thickness: 2),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: buttonMaker(
                          context,
                          () => showNamesaDetails(context),
                          "About Namesa",
                          60,
                          200,
                          Theme.of(context).focusColor,
                          Colors.transparent,
                          Colors.white,
                        ),
                      ),
                      Expanded(
                        child: buttonMaker(
                          context,
                          () async {
                            ///Circular Progress Indicator
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder:
                                  (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                            );

                            ///log out
                            try {
                              final authProvider =
                                  Provider.of<AuthenticationProvider>(
                                    context,
                                    listen: false,
                                  );
                              await authProvider.logOut();
                            } catch (e) {
                              debugPrint("Logout failed: $e");
                            }

                            /// Wait for 2 seconds before navigating
                            await Future.delayed(const Duration(seconds: 3));

                            Navigator.pop(context); // Close the loading dialog
                            Navigator.pushReplacementNamed(
                              context,
                              AuthScreen.routeName,
                            );
                          },

                          "Log Out",
                          60,
                          200,
                          Colors.transparent,
                          Theme.of(context).focusColor,
                          Theme.of(context).focusColor,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AdminScreen.routeName);
                    },
                    child: child,
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget buttonMaker(
    BuildContext context,
    void Function() onTap,
    String text,
    double height,
    double width,
    Color backGroundColor,
    Color borderColor,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showNamesaDetails(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "About Namesa",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).focusColor,
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: SingleChildScrollView(
              child: Text('''
Vision:
To become the leading integrated hospitality and entertainment destination in New Cairo, recognized nationally and internationally as a model of luxury hospitality and refined cultural experiences.

To blend contemporary architectural design with authentic Egyptian touches, creating an environment inspired by history while offering the highest standards of comfort and luxury.

To serve as a benchmark in integrating a premium casino experience within a unique tourism offering, while upholding the highest standards of safety and social responsibility.

Mission:
To deliver exceptional hospitality services that combine personalized care with innovative technology, ensuring we meet and exceed our guests’ expectations.

To create a fully immersive entertainment environment that includes gaming and exclusive events for gamblers, within an ethical framework that prioritizes guest safety and well-being.

To support local culture and the economy by showcasing Egyptian arts and crafts and organizing events that strengthen community engagement.

To commit to sustainable practices in all our operations—from waste management to water and energy conservation—in alignment with our goals for social responsibility.
          ''', style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
    );
  }
}
