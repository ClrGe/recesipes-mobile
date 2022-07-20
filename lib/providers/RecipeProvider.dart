import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../providers/AuthProvider.dart';
import '../services/api.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe> recipes = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  RecipeProvider(AuthProvider authProvider) {
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);

    init();
  }

  Future init() async {
    recipes = await apiService.fetchRecipes();
    notifyListeners();
  }

  Future<void> addRecipe(
      String amount, String category, String description, String date) async {
    try {
      Recipe addedRecipe =
          await apiService.addRecipe(amount, category, description, date);
      recipes.add(addedRecipe);

      notifyListeners();
    } catch (Exception) {
      await authProvider.logOut();
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      Recipe updatedRecipe = await apiService.updateRecipe(recipe);
      int index = recipes.indexOf(recipe);
      recipes[index] = updatedRecipe;

      notifyListeners();
    } catch (Exception) {
      await authProvider.logOut();
    }
  }

  Future<void> deleteRecipe(Recipe recipe) async {
    try {
      await apiService.deleteRecipe(recipe.id);

      recipes.remove(recipe);
      notifyListeners();
    } catch (Exception) {
      await authProvider.logOut();
    }
  }
}
