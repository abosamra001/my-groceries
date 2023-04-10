import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

// here we simply paint our list of transactions
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeAt;
  const TransactionList(
      {super.key, required this.transactions, required this.removeAt});
  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? Container(
            height: 550,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shadowColor: Colors.blue,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              radius: 28,
                              child: FittedBox(
                                child: Text(
                                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactions[index].title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd()
                                      .format(transactions[index].date),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            removeAt(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          // color: Colors.red,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You have no items yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.center,
              ),
              Image.asset(
                'assets/images/sloth_animal.png',
                fit: BoxFit.cover,
              ),
            ],
          );
  }
}
