import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/screens/Order/Profile/editprofile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRoutes.nav);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Gaph(height: 50),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          "lib/innitiel_screens/images/profileimg.png"),
                    ),
                    SizedBox(height: 10),
                    Apptext(
                      text: "Dnyaneshwar Jadhav",
                      color: Appcolor.primaryRed,
                      fontWeight: FontWeight.bold,
                    ),
                    Apptext(
                      text: "dnyaneshwar@example.com",
                      color: Appcolor.primaryRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // _buildProfileOption(Icons.person, "Edit Profile", () {
              //   Navigator.push(
              
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => EditprofileScreen()));
              // }),
              _buildProfileOption(Icons.settings, "Settings", () {}),
              _buildProfileOption(Icons.lock, "Privacy Policy", () {}),
              _buildProfileOption(
                  Icons.notification_add, "Notifications", () {}),
              _buildProfileOption(
                  Icons.local_shipping_outlined, "Your Order", () {}),
              _buildProfileOption(Icons.settings, "Account setting", () {}),
              _buildProfileOption(Icons.logout, "Logout", () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Appcolor.primaryRed,
      ),
      title: Apptext(
        text: title,
        fontWeight: FontWeight.bold,
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.grey),
      onTap: onTap,
    );
  }
}
