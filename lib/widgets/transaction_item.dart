import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          foregroundColor: Theme.of(context).primaryColorLight,
          backgroundColor: Theme.of(context).primaryColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(child: Text('\$${transaction.amount}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat('d MMMM, y').format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                label: const Text('Delete'),
                icon: const Icon(Icons.delete),
                style: IconButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error),
                onPressed: () => deleteTx(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: /*() => deleteTx(transaction.id)*/ () async {
                  if (await confirm(context,
                      title: const Text('Confirm'),
                      content: const Text(
                          'Are you sure you want to delete this expense?'),
                      textOK: const Text('Yes'),
                      textCancel: const Text('No'))) deleteTx(transaction.id);
                },
              ),
      ),
    );
  }
}
