import '../models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/category.dart';
import 'package:provider/provider.dart';
import '../providers/CategoryProvider.dart';

class RecipeEdit extends StatefulWidget {
  final Recipe recipe;
  final Function recipeCallback;

  RecipeEdit(this.recipe, this.recipeCallback, {Key? key}) : super(key: key);

  @override
  _RecipeEditState createState() => _RecipeEditState();
}

class _RecipeEditState extends State<RecipeEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final recipeAmountController = TextEditingController();
  final recipeCategoryController = TextEditingController();
  final recipeDescriptionController = TextEditingController();
  final recipeDateController = TextEditingController();
  String errorMessage = '';

  @override
  void initState() {
    recipeAmountController.text = widget.recipe.guestsNumber.toString();
    recipeCategoryController.text = widget.recipe.categoryId.toString();
    recipeDescriptionController.text = widget.recipe.description.toString();
    recipeDateController.text = widget.recipe.publishedTime.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                controller: recipeAmountController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^-?(\d+\.?\d{0,2})?')),
                ],
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre invités',
                  icon: Icon(Icons.attach_money),
                  hintText: '0',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Nombre invités requis';
                  }
                  final newValue = double.tryParse(value);

                  if (newValue == null) {
                    return 'Format invalide';
                  }
                },
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
              buildCategoriesDropdown(),
              TextFormField(
                controller: recipeDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Fournissez une description';
                  }

                  return null;
                },
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
              TextFormField(
                controller: recipeDateController,
                onTap: () {
                  selectDate(context);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Publication date',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Date is required';
                  }

                  return null;
                },
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Enregistrer'),
                      onPressed: () => saveRecipe(context),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Text('Annuler'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ]),
              Text(errorMessage, style: TextStyle(color: Colors.red))
            ])));
  }

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (picked != null)
      setState(() {
        recipeDateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
  }

  Widget buildCategoriesDropdown() {
    return Consumer<CategoryProvider>(
      builder: (context, cProvider, child) {
        List<Category> categories = cProvider.categories;

        return DropdownButtonFormField(
          elevation: 8,
          items: categories.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
                value: e.id.toString(),
                child: Text(e.type,
                    style: TextStyle(color: Colors.black, fontSize: 20.0)));
          }).toList(),
          value: recipeCategoryController.text,
          onChanged: (String? newValue) {
            if (newValue == null) {
              return;
            }

            setState(() {
              recipeCategoryController.text = newValue.toString();
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Catégorie',
          ),
          dropdownColor: Colors.white,
          validator: (value) {
            if (value == null) {
              return 'Choississez une catégorie';
            }
          },
        );
      },
    );
  }

  Future saveRecipe(context) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.recipe.categoryId = recipeCategoryController.text;
    widget.recipe.description = recipeDescriptionController.text;
    widget.recipe.publishedTime = recipeDateController.text;

    await widget.recipeCallback(widget.recipe);
    Navigator.pop(context);
  }
}
