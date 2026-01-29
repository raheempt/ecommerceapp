import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class SignupPage extends StatefulWidget {
  
  const SignupPage({super.key});
  

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
    String locationMsg = "Press the button to get location";
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMsg = "Location services are disabled";
      });
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMsg = "Location permission denied";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMsg = "Permission permanently denied";
      });
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      locationMsg =
          "Latitude: ${position.latitude}\nLongitude: ${position.longitude}";
    });
  }
  // final TextEditingController nameCtrl = TextEditingController();
  // final TextEditingController emailCtrl = TextEditingController();
  // final TextEditingController locationCtrl = TextEditingController();
  // final TextEditingController passCtrl = TextEditingController();
  // final TextEditingController confirmCtrl = TextEditingController();
   final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool agreeTerms = false;
  bool showPassword = false;

 void signup() {
    final box = Hive.box('logindata');
    List users = box.get('users', defaultValue: []);

    bool exists =
        users.any((u) => u['email'] == emailCtrl.text.trim());

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User already exists")),
      );
      return;
    }

    users.add({
      'name': nameCtrl.text.trim(),
      'email': emailCtrl.text.trim(),
      'password': passCtrl.text.trim(),
    });

    box.put('users', users);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Signup successful")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.pop(context),
                    child: const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Create Account",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            /// 🔹 Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    /// 🔹 Logo
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 12,
                            color: Colors.black26,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),

                    const SizedBox(height: 24),

                 
                    const SizedBox(height: 8),
                    Text(
                      "Enter your details to create your account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(color: Colors.grey),
                    ),

                    const SizedBox(height: 32),

                    _inputField(
                        controller: nameCtrl,
                      label: "Full Name",
                      // hint: "John Doe",
                      icon: Icons.person,
                    ),

                    const SizedBox(height: 16),

                    _inputField(
                       controller: emailCtrl,
                      label: "Email Address",
                      // hint: "name@example.com",
                      icon: Icons.mail,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),
                      Text(
                locationMsg,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),

                    // _inputField(
                    //   controller: locationCtrl,
                    //   label: "Location",
                    //   hint: "City, Country",
                    //   icon: Icons.location_on,
                    // ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: getCurrentLocation,
                        icon: const Icon(Icons.my_location, size: 18),
                        label: const Text("Detect My Location"),
                      ),
                    ),

                    const SizedBox(height: 8),

                    _inputField(
                      controller: passCtrl,
                      label: "Password",
                      // hint: "••••••••",
                      icon: showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      // obscure: !showPassword,
                      onIconTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // _inputField(
                    //   controller: confirmCtrl,
                    //   label: "Confirm Password",
                    //   hint: "••••••••",
                    //   icon: Icons.lock,
                    //   obscure: true,
                    // ),

                    const SizedBox(height: 16),

                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: agreeTerms,
                    //       onChanged: (val) {
                    //         setState(() {
                    //           agreeTerms = val!;
                    //         });
                    //       },
                    //     ),
                    //     Expanded(
                    //       child: Text.rich(
                    //         TextSpan(
                    //           text: "I agree to the ",
                    //           children: [
                    //             TextSpan(
                    //               text: "Terms & Conditions",
                    //               style: const TextStyle(
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 8),

                    ///  Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: signup,
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),


                 

                    const SizedBox(height: 94),



                    /// 🔹 Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Input
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    // required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onIconTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            // hintText: hint,
            suffixIcon: IconButton(
              icon: Icon(icon),
              onPressed: onIconTap,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 Social Button
  Widget _socialButton({
    required IconData icon,
    required String text,
    required bool dark,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: dark ? Colors.white : Colors.black),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: dark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
