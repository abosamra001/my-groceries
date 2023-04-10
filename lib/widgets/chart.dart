import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  // double totalOverAllWeek = 0.0;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i in recentTransactions) {
        // totalOverAllWeek += i.amount;
        if (DateFormat.E().format(i.date) == DateFormat.E().format(weekDay)) {
          totalSum += i.amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, e) {
      return sum + (e['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionValues.map((e) {
          double daySpending = e['amount'] as double;
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              label: e['day'].toString(),
              spending: daySpending,
              ratio: totalSpending == 0 ? 0.0 : daySpending / totalSpending,
            ),
          );
        }).toList(),
      ),
    );
  }
}
