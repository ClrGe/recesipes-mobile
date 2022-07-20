import 'package:flutter/material.dart';
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
        title: Text('Recipes'),
        backgroundColor: Color(0xFFEE8B60),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          Recipe recipe = recipes[index];
          return ListTile(
            title: Text('\$' + recipe.name),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(recipe.publishedTime),
                Text(recipe.description),
              ]),
              IconButton(
                color: Color(0xFFEE8B60),
                icon: Icon(Icons.edit),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return RecipeEdit(recipe, provider.updateRecipe);
                      });
                },
              ),
              IconButton(
                color: Color(0xFFEE8B60),
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirmation"),
                          content: Text(
                              "Voulez vous vraiment supprimer ce contenu?"),
                          actions: [
                            TextButton(
                              child: Text("Annuler"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                                child: Text("Supprimer"),
                                onPressed: () => deleteRecipe(
                                    provider.deleteRecipe, recipe, context)),
                          ],
                        );
                      });
                },
              )
            ]),
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
