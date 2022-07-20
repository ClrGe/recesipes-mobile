import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/RecipeAdd.dart';
import '../widgets/RecipeEdit.dart';
import 'package:provider/provider.dart';
import '../providers/RecipeProvider.dart';

class Recipes extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
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
            title: Text('\$' + recipe.amount),
            subtitle: Text(recipe.categoryName),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(recipe.transactionDate),
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
                        return TransactionEdit(
                            recipe, provider.updateTransaction);
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
                                onPressed: () => deleteTransaction(
                                    provider.deleteTransaction,
                                    recipe,
                                    context)),
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
                  return TransactionAdd(provider.addTransaction);
                });
          },
          backgroundColor: Color(0xFFEE8B60),
          child: Icon(Icons.add)),
    );
  }

  Future deleteTransaction(
      Function callback, Recipe recipe, BuildContext context) async {
    await callback(recipe);
    Navigator.pop(context);
  }
}
