import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteRecipes = favoritesProvider.favorites;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/cookie_logo.png',
              fit: BoxFit.cover,
            ),
          ),


          Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: Center(
                  child: Image.asset(
                    'assets/choco_cookies_logo.png',
                    height: 50,
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),


              Expanded(
                child: favoriteRecipes.isEmpty
                    ? Center(
                  child: Text(
                    'No favorites yet!',
                    style: TextStyle(fontSize: 16, color: Colors.brown),
                  ),
                )
                    : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: favoriteRecipes.length,
                  itemBuilder: (context, index) {
                    final item = favoriteRecipes[index];
                    return Card(
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
                        trailing: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Color(0xFFAE7C7C),
                          ),
                          onPressed: () {
                            favoritesProvider.removeFavorite(item);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRatingStars(double rating) {
    return List.generate(5, (index) {
      if (index < rating) {
        return Icon(Icons.star, color: Colors.orange, size: 16);
      } else {
        return Icon(Icons.star_border, color: Colors.orange, size: 16);
      }
    });
  }
}
