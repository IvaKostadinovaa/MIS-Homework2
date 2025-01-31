import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import 'favorites_screen.dart';
import 'add_recipe_screen.dart';
import 'profile_screen.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String selectedCategory = "Cookies";

  List<Map<String, dynamic>> allRecipes = [
    {
      'title': 'Cookies with bite of Choco',
      'category': 'Cookies',
      'rating': 4.5,
      'image': 'assets/Cookies_with_bite_of_Choco.png',
    },
    {
      'title': 'Choco Strawberry Swirl',
      'category': 'Cookies',
      'rating': 4.0,
      'image': 'assets/Choco_Strawberry_Swirl.png',
    },
    {
      'title': 'Milky Way Sweet Cookies',
      'category': 'Cookies',
      'rating': 4.5,
      'image': 'assets/milky_way_sweet_cookies.png',
    },
    {
      'title': 'Cocoa and Melon Cookies',
      'category': 'Cookies',
      'rating': 4.0,
      'image': 'assets/Cocoa_and_melon_Cookies.png',
    },
  ];

  void addNewRecipe(Map<String, dynamic> recipe) {
    setState(() {
      allRecipes.add(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeTab(
            selectedCategory: selectedCategory,
            allRecipes: allRecipes,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
          FavoritesScreen(),
          AddRecipeScreen(onRecipeAdded: addNewRecipe),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Recipe'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final String selectedCategory;
  final List<Map<String, dynamic>> allRecipes;
  final Function(String) onCategorySelected;

  HomeTab({required this.selectedCategory, required this.allRecipes, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredRecipes =
    allRecipes.where((recipe) => recipe['category'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: Color(0xFFF5EBDC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/choco_cookies_logo.png', height: 40),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.brown),
                  filled: true,
                  fillColor: Colors.brown[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),


              Text(
                'Best of Today',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  final item = allRecipes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(recipe: item),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item['image'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item['title'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.brown),
                        ),
                        subtitle: Row(
                          children: [
                            Text(item['category'], style: TextStyle(fontSize: 12)),
                            SizedBox(width: 5),
                            ..._buildRatingStars(item['rating']),
                          ],
                        ),
                        trailing: Consumer<FavoritesProvider>(
                          builder: (context, favoritesProvider, _) {
                            final isFavorite = favoritesProvider.isFavorite(item);
                            return IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Color(0xFFAE7C7C) : Colors.brown,
                              ),
                              onPressed: () {
                                if (isFavorite) {
                                  favoritesProvider.removeFavorite(item);
                                } else {
                                  favoritesProvider.addFavorite(item);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),


              Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['Cookies', 'Donuts', 'Breads', 'Cupcakes'].map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        selectedColor: Colors.brown,
                        backgroundColor: Colors.brown[100],
                        labelStyle: TextStyle(
                          color: selectedCategory == category ? Colors.white : Colors.brown,
                        ),
                        onSelected: (bool selected) {
                          if (selected) {
                            onCategorySelected(category);
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),


              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final product = filteredRecipes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(recipe: product),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              product['image'],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            product['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.brown, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRatingStars(double rating) {
    return List.generate(5, (index) => Icon(index < rating ? Icons.star : Icons.star_border, color: Colors.orange, size: 16));
  }
}
