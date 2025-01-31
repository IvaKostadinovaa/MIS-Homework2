import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  ProductDetailsScreen({required this.recipe});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(recipe['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['title'],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      _buildIngredientChip("Chocolate", Icons.cake),
                      _buildIngredientChip("Flour", Icons.grain),
                      _buildIngredientChip("Milk", Icons.local_drink),
                    ],
                  ),
                  SizedBox(height: 20),


                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Delightful, chewy cookies with chunks of Milky Way bars melted into the batter. Perfect for satisfying your sweet tooth and impressing friends and family!",
                    style: TextStyle(fontSize: 14, color: Colors.brown),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "1. Preheat Oven: Preheat to 350°F (175°C).\n"
                        "2. Mix Ingredients: Cream butter and sugar, then add eggs and vanilla.\n"
                        "3. Gradually add flour and baking soda.\n"
                        "4. Add Milky Way: Stir in chopped Milky Way bars.\n"
                        "5. Shape and Bake: Shape dough into balls, place on a baking sheet, and bake for 10-12 minutes.",
                    style: TextStyle(fontSize: 14, color: Colors.brown),
                  ),
                  SizedBox(height: 30),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.brown[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Do you need the ingredients for this recipe?",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Icon(Icons.shopping_cart, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientChip(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        backgroundColor: Colors.brown[200],
        label: Row(
          children: [
            Icon(icon, color: Colors.brown, size: 18),
            SizedBox(width: 5),
            Text(label, style: TextStyle(color: Colors.brown)),
          ],
        ),
      ),
    );
  }
}
