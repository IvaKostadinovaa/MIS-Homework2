import 'package:flutter/material.dart';
import 'success_screen.dart';

class ChangeEmailScreen extends StatefulWidget {
  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

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
          'Change Email',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField('New Email', 'newemail@gmail.com', emailController, icon: Icons.check),
            SizedBox(height: 16),
            Text(
              'A verification code has been sent to your new email account. Please enter it below to confirm.',
              style: TextStyle(fontSize: 14, color: Colors.brown),
            ),
            SizedBox(height: 8),
            _buildInputField('Verification Code', '123456', codeController),
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
                  child: _buildButton('Save Email', Color(0xFF5C3829), Colors.white, () {
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

  Widget _buildInputField(String label, String hint, TextEditingController controller, {IconData? icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.brown[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: icon != null ? Icon(icon, color: Colors.brown) : null,
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
