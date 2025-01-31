import 'package:flutter/material.dart';

class AddRecipeScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onRecipeAdded;

  AddRecipeScreen({required this.onRecipeAdded});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();

  String selectedCategory = "Cookies";
  final List<String> categories = ["Cookies", "Donuts", "Breads", "Cupcakes"];

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
          'Add Recipe',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField('NAME', 'Recipe name', titleController),
            SizedBox(height: 16),

            Text(
              'CATEGORY',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.brown),
                  items: categories.map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(color: Colors.brown),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),

            _buildInputField('DESCRIPTION', 'Description...', descriptionController),
            SizedBox(height: 16),
            _buildInputField('INGREDIENTS', 'Ingredients...', ingredientsController),
            SizedBox(height: 16),
            _buildInputField('STEPS', '1. ...\n2. ...', stepsController, maxLines: 3),
            SizedBox(height: 20),

            Text(
              'Upload Image',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.brown),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.brown, width: 1.5),
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.brown,
                    size: 50,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),


            Row(
              children: [
                Expanded(
                  child: _buildButton('Cancel', Color(0xFFAE7C7C), Colors.white, () {
                    _resetFields();
                  }),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildButton('Save', Color(0xFF5C3829), Colors.white, () {
                    _saveRecipe();
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildInputField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: textColor),
        ),
      ),
    );
  }


  void _resetFields() {
    setState(() {
      titleController.clear();
      descriptionController.clear();
      ingredientsController.clear();
      stepsController.clear();
      selectedCategory = "Cookies";
    });
  }

  void _saveRecipe() {
    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      final newRecipe = {
        'title': titleController.text,
        'category': selectedCategory,
        'rating': 4.5,
        'image': 'assets/default_recipe.png',
      };

      widget.onRecipeAdded(newRecipe);


      Navigator.pop(context);
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a recipe title and description')),
      );
    }
  }
}

