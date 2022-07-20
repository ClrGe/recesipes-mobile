import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/TransactionAdd.dart';
import '../widgets/TransactionsEdit.dart';
import 'package:provider/provider.dart';
import '../providers/TransactionProvider.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    List<Transaction> transactions = provider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        backgroundColor: Color(0xFFEE8B60),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          Transaction transaction = transactions[index];
          return ListTile(
            title: Text('\$' + transaction.amount),
            subtitle: Text(transaction.categoryName),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(transaction.transactionDate),
                Text(transaction.description),
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
                            transaction, provider.updateTransaction);
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
                                    transaction,
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
      Function callback, Transaction transaction, BuildContext context) async {
    await callback(transaction);
    Navigator.pop(context);
  }
}
