import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure to use .svg files with this

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
                                      color:
                                          isSignUp
                                              ? Colors.white
                                              : Colors.black,
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
                                      color:
                                          !isSignUp
                                              ? Colors.white
                                              : Colors.black,
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
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Enter email or username',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
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
                          style: Theme.of(context).textTheme.bodyMedium,
                          obscureText: isSecured1,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
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
                            controller: confirmPasswordControllingSighUp,
                            style: Theme.of(context).textTheme.bodyMedium,
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
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      /// Submit
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
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
