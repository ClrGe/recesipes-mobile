import 'package:flutter/material.dart';
import '../widgets/CategoryAdd.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../widgets/CategoryEdit.dart';
import '../providers/CategoryProvider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Color(0xFFEE8B60),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          Category category = categories[index];
          return ListTile(
            title: Text(category.name),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return CategoryEdit(category, provider.updateCategory);
                      });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirmation"),
                          content: Text("Voulez vous supprimer ce contenu ?"),
                          actions: [
                            TextButton(
                              child: Text("Annuler"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                                child: Text("Supprimer"),
                                onPressed: () => deleteCategory(
                                    provider.deleteCategory, category)),
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
                  return CategoryAdd(provider.addCategory);
                });
          },
          backgroundColor: Color(0xFFEE8B60),
          child: Icon(Icons.add)),
    );
  }

  Future deleteCategory(Function callback, Category category) async {
    await callback(category);
    Navigator.pop(context);
  }
}
