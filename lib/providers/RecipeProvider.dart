import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../providers/AuthProvider.dart';
import '../services/api.dart';

class TransactionProvider extends ChangeNotifier {
  List<Recipe> recipes = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  TransactionProvider(AuthProvider authProvider) {
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);

    init();
  }

  Future init() async {
    recipes = await apiService.fetchTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(
      String amount, String category, String description, String date) async {
    try {
      Recipe addedTransaction =
          await apiService.addTransaction(amount, category, description, date);
      recipes.add(addedTransaction);

      notifyListeners();
    } catch (Exception) {
      await authProvider.logOut();
    }
  }

  Future<void> updateTransaction(Recipe recipe) async {
    try {
      Recipe updatedTransaction = await apiService.updateTransaction(recipe);
      int index = recipes.indexOf(recipe);
      recipes[index] = updatedTransaction;

      notifyListeners();
    } catch (Exception) {
      await authProvider.logOut();
    }
  }

  Future<void> deleteTransaction(Recipe recipe) async {
    try {
      await apiService.deleteTransaction(recipe.id);

      recipes.remove(recipe);
      notifyListeners();
    } catch (Exception) {
      await authProvider.logOut();
    }
  }
}
