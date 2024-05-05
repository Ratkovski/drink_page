import 'dart:convert';
import '/pages/cocktail_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cocktail Search',
      // theme: ThemeData(
      //   primaryColor: Color(0xFF28bcc7),
      //   scaffoldBackgroundColor: Color(0xFFe8e6eb),
      //   textTheme: TextTheme(
      //     headline6: TextStyle(color: Colors.white),
      //   ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF220342)),
      // ),
      home: CocktailSearchScreen(),
    );
  }
}

class CocktailSearchScreen extends StatefulWidget {
  @override
  _CocktailSearchScreenState createState() => _CocktailSearchScreenState();
}

class _CocktailSearchScreenState extends State<CocktailSearchScreen> {
  List<dynamic> _cocktails = [];
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();

  Future<void> _fetchCocktails(String searchTerm) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$searchTerm'));

    setState(() {
      _isLoading = false;
      _cocktails = json.decode(response.body)['drinks'];
    });
  }

 void _showCocktailDetails(dynamic cocktail) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          cocktail['strDrink'],
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // Bordas arredondadas
              child: Image.network(
                cocktail['strDrinkThumb'],
                height: 260,
                width: 260,
              ),
            ),
            SizedBox(height: 10),
            Text('Ingredients:', style: TextStyle(color: Colors.white)),
            SizedBox(height: 5),
            for (int i = 1; i <= 15; i++) // Assuming max 15 ingredients
              if (cocktail['strIngredient$i'] != null)
                Text(
                  '${cocktail['strMeasure$i']} ${cocktail['strIngredient$i']}',
                  style: TextStyle(color: Colors.white),
                ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToDetailsScreen(cocktail);
            },
            child: Text('Details'),
          ),
        ],
      );
    },
  );
}

    void _navigateToDetailsScreen(dynamic cocktail) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CocktailDetailsScreen(cocktail: cocktail)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Cocktail Search',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(color: Colors.black),

              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Name Cocktail ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.black45),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.black45),
                  onPressed: () {
                    _fetchCocktails(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _cocktails.isEmpty
                    ? Center(child: Text('No cocktails found', style: TextStyle(color: Colors.black54)))
                    : ListView.builder(
                        itemCount: _cocktails.length,
                        itemBuilder: (context, index) {
                          final cocktail = _cocktails[index];
                          return ListTile(
                            title: Text(cocktail['strDrink'], style: TextStyle(color: Colors.black87)),
                            subtitle: Text(cocktail['strCategory'], style: TextStyle(color: Colors.black)),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(cocktail['strDrinkThumb']),
                            ),
                            onTap: () {
                              _showCocktailDetails(cocktail);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
