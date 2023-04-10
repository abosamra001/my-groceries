import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// this is the part in which we can add new transaction

class NewTransaction extends StatefulWidget {
  final Function addTx;
  const NewTransaction({required this.addTx, super.key});
  @override
  State<StatefulWidget> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _datePicked;

  void _submit() {
    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
      _datePicked,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      _datePicked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Title')),
              controller: _titleController,
              textInputAction: TextInputAction.next,
              autofocus: true,
            ),
            TextField(
              decoration: const InputDecoration(label: Text('Amount')),
              controller: _amountController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(),
            ),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text(
                        _datePicked == null
                            ? 'No Date Chosien'
                            : DateFormat.yMd().format(_datePicked!),
                      ),
                    ),
                    enabled: false,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: IconButton(
                    onPressed: _datePicker,
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.purple,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: _submit,
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
