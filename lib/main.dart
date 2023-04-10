import 'package:flutter/material.dart';
import './widgets/new_transation.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transactions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Quicksand',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Map<String, MyChart> myExpenses;
  final List<Transaction> _userTransactions = [
    // Transaction(title: 'ab', amount: 8.9, date: DateTime.now()),
  ];
  List<Transaction> get _recentUserTransaction {
    return _userTransactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _removeTransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  void _startAddNewTransaction(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => NewTransaction(addTx: _addNewTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        splashColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        children: [
          Chart(_recentUserTransaction),
          TransactionList(
            transactions: _userTransactions,
            removeAt: _removeTransaction,
          ),
        ],
      ),
    );
  }
}
