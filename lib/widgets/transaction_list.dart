import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, Constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: Constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(children: [
            // ListView.builder for only loading what's visible and not loaded. But delete one, the colors of others will be changed.
            ...transactions
                .map((tx) => TransactionItem(
                    key: ValueKey(tx
                        .id), // delete the iten, the remaining item's color will not change. Unlike UniqueKey(), ValueKey() does not (re-)calculate
                    // a random value but wraps a non-changing identifier provided by you.
                    transaction: tx,
                    deleteTx: deleteTx))
                .toList(), // ListView is infinite in height and thus must be given the constraints
          ]);
  }
}
