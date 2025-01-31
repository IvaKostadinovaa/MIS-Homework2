
import 'package:flutter/material.dart';
import 'profile_settings/change_full_name_screen.dart';
import 'profile_settings/change_email_screen.dart';
import 'profile_settings/change_password_screen.dart';
import 'Recipes_added_by_you.dart';
import 'WelcomeScreen.dart';

class ProfileScreen extends StatelessWidget {
  final Color mainColor = Color(0xFFAE7C7C);
  final Color logoutColor = Color(0x99AE7C7C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EBDC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile_picture.png'),
                  backgroundColor: Colors.brown[100],
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subaida Rahman',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    Text(
                      'subaidarahman22@gmail.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),

            Text(
              'Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 20),

            _buildEditableField(
              context: context,
              label: 'Full Name',
              value: 'Subaida Rahman',
              icon: Icons.edit,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeFullNameScreen()),
                );
              },
            ),
            SizedBox(height: 20),


            _buildEditableField(
              context: context,
              label: 'Email',
              value: 'subaidarahman22@gmail.com',
              icon: Icons.edit,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeEmailScreen()),
                );
              },
            ),
            SizedBox(height: 20),

            _buildEditableField(
              context: context,
              label: 'Password',
              value: '********',
              icon: Icons.lock,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            SizedBox(height: 30),

            _buildActionButton(
              text: 'View Recipes Added by You',
              color: mainColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyRecipesScreen()),
                );
              },
            ),
            SizedBox(height: 10),

            _buildActionButton(
              text: 'Change Profile Picture',
              color: mainColor,
              onPressed: () {
              },
            ),
            SizedBox(height: 10),

            _buildActionButton(
              text: 'Log Out',
              color: logoutColor,
              textColor: Colors.brown,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.brown[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Icon(icon, color: Colors.brown),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    Color? textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
