import 'package:flutter/material.dart';
import 'success_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool obscureText = true;

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
        title: Text(
          'Change Password',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField('Old Password', 'helloworld@gmail.com', oldPasswordController, icon: Icons.check),
            SizedBox(height: 16),
            _buildPasswordField('New Password', newPasswordController),
            SizedBox(height: 16),
            _buildPasswordField('Confirm New Password', confirmPasswordController),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: _buildButton('Cancel', Color(0xFFAE7C7C), Colors.white, () {
                    Navigator.pop(context);
                  }),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildButton('Save New Password', Color(0xFF5C3829), Colors.white, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SuccessScreen()),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return _buildInputField(label, '********', controller, isPassword: true);
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, {IconData? icon, bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.brown[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.brown),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        )
            : (icon != null ? Icon(icon, color: Colors.brown) : null),
      ),
    );
  }

  Widget _buildButton(String text, Color color, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text(text, style: TextStyle(fontSize: 16, color: textColor)),
    );
  }
}
