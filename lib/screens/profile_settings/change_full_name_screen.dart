import 'package:flutter/material.dart';
import 'success_screen.dart';

class ChangeFullNameScreen extends StatefulWidget {
  @override
  _ChangeFullNameScreenState createState() => _ChangeFullNameScreenState();
}

class _ChangeFullNameScreenState extends State<ChangeFullNameScreen> {
  final TextEditingController firstNameController = TextEditingController(text: "Subaida");
  final TextEditingController lastNameController = TextEditingController(text: "Rahman");

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField("Name", firstNameController),
            SizedBox(height: 16),
            _buildInputField("Surname", lastNameController),
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
                  child: _buildButton('Save Full Name', Color(0xFF5C3829), Colors.white, () {
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

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.brown[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildButton(String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text, style: TextStyle(fontSize: 16, color: textColor)),
      ),
    );
  }
}
