import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/guest_model.dart';

import '../auth provider/auth_provider.dart';
import '../home screens/tabs/home_tab.dart';
import '../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "AuthScreen";

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignUp = true;
  bool isSecured1 = true;
  bool isSecured2 = true;
  final nameControllerSignUp = TextEditingController();
  final emailControllingSighUp = TextEditingController();
  final emailControllingLogIn = TextEditingController();
  final passwordControllingSighUp = TextEditingController();
  final passwordControllingLogIn = TextEditingController();
  final confirmPasswordControllingSighUp = TextEditingController();
  final confirmPasswordControllingLogIn = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void toggleForm() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 296, // Reduced to save space
                  child: Image.asset("assets/pictures/namesa logo.png"),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 316,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Toggle Switch
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (!isSignUp) toggleForm();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        isSignUp
                                            ? Colors.black
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Theme.of(context).focusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (isSignUp) toggleForm();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        !isSignUp
                                            ? Colors.black
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                      color: Theme.of(context).focusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      if (isSignUp)
                        /// Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Name Is Required";
                              }
                              return null;
                            },
                            onTapOutside:
                                (event) => FocusScope.of(context).unfocus(),
                            controller: nameControllerSignUp,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Enter Your Name',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),

                      /// Email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email Is Required";
                            }
                            final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                            ).hasMatch(value);

                            if (!emailValid) {
                              return "Email Is Not Valid";
                            } else {
                              return null;
                            }
                          },
                          controller:
                              isSignUp
                                  ? emailControllingSighUp
                                  : emailControllingLogIn,
                          onTapOutside:
                              (event) => FocusScope.of(context).unfocus(),

                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Enter email or username',
                            hintStyle: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// Password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password Is Required";
                            }
                            if (value.length < 6) {
                              return "Password Should Be More Than 6 Characteristics";
                            }
                            return null;
                          },
                          controller:
                              isSignUp
                                  ? passwordControllingSighUp
                                  : passwordControllingLogIn,
                          onTapOutside:
                              (event) => FocusScope.of(context).unfocus(),

                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                          obscureText: isSecured1,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSecured1 = !isSecured1;
                                });
                              },
                              child: Icon(
                                isSecured1
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// Confirm Password
                      /// Confirm Password
                      if (isSignUp)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password Is Required";
                              }
                              if (value != passwordControllingSighUp.text) {
                                return "Password Doesn't Match";
                              }
                              if (value.length < 6) {
                                return "Password Should Be More Than 6 Characters";
                              }
                              return null;
                            },
                            onTapOutside:
                                (event) => FocusScope.of(context).unfocus(),

                            controller: confirmPasswordControllingSighUp,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                            obscureText: isSecured2,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSecured2 = !isSecured2;
                                  });
                                },
                                child: Icon(
                                  isSecured2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      /// Submit
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // Show loading dialog before async operation
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder:
                                  (BuildContext context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            );

                            final AuthService auth = AuthenticationProvider();
                            GuestModel? guest;

                            try {
                              if (isSignUp) {
                                guest = await auth.registerWithEmailAndPassword(
                                  emailControllingSighUp.text.trim(),
                                  passwordControllingSighUp.text.trim(),
                                  nameControllerSignUp.text.trim(),
                                );
                              } else {
                                guest = await auth.loginWithEmailAndPassword(
                                  emailControllingLogIn.text.trim(),
                                  passwordControllingLogIn.text.trim(),
                                );
                              }
                            } catch (e) {
                              debugPrint('Error: $e');
                            } finally {
                              // Close the loading dialog only if the widget is still mounted
                              if (mounted) {
                                Navigator.pop(
                                  context,
                                ); // Close the loading dialog
                              }
                            }

                            if (guest != null) {
                              // Successful login/signup, navigate to the home screen
                              Navigator.pushNamed(context, HomeTab.routeName);
                            } else {
                              // Show an error dialog if registration/login fails
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          color: Theme.of(context).focusColor,
                                        ),
                                        child: Icon(
                                          Icons.error_outline,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      content: Text(
                                        'Login/Registration failed. Please check your credentials or verify your email.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'OK',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall!.copyWith(
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).focusColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 30,
                          ),
                        ),
                        child: Text(
                          isSignUp ? "Sign Up" : "Log In",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                      ),
                      const SizedBox(height: 10),
                      isSignUp
                          ? Container()
                          : Column(
                            children: [
                              Text(
                                "OR",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sign In With Google",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!.copyWith(
                                            color: Theme.of(context).focusColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
