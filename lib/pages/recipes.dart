import 'package:flutter/material.dart';
import 'package:recesipes_app/pages/PhotoPicker.dart';
import 'package:recesipes_app/pages/recipeDetails.dart';
import '../models/recipe.dart';
import '../widgets/RecipeCreate.dart';
import '../widgets/RecipeUpdate.dart';
import 'package:provider/provider.dart';
import '../providers/RecipeProvider.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    List<Recipe> recipes = provider.recipes;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Toutes les recettes'),
        backgroundColor: Color(0xFFEE8B60),
        actions: [
          Padding(padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            child: Icon(Icons.camera_alt),
            onTap: () { Navigator.push(context, MaterialPageRoute(
              builder: (context) => PhotoPicker(),
            )); },
          ))
        ],
      ),
      body: ListView.separated(
        itemCount: recipes.length,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black,
          );
        },
        itemBuilder: (context, index) {
          Recipe recipe = recipes[index];
          return GestureDetector(
            onTap: () { Navigator.push(context, MaterialPageRoute(
              builder: (context) => RecipeDetails(recipe: recipe,),
            ),); },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(recipe.name,
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(recipe.description, style: TextStyle(fontSize: 10)),
                        Text('${recipe.pricing} | ${recipe.difficulty}', style: TextStyle(fontSize: 20)),
                      ],
                    ),

                  ],
                ),
              ),
            )
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return RecipeAdd(provider.addRecipe);
                });
          },
          backgroundColor: Color(0xFFEE8B60),
          child: Icon(Icons.add)),
    );
  }

  Future deleteRecipe(
      Function callback, Recipe recipe, BuildContext context) async {
    await callback(recipe);
    Navigator.pop(context);
  }
}
