import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDate;

  void submet() {
    if (amountController.text.isEmpty) {
      return;
    }
    final entredTitle = titleController.text;
    final entredAmount = double.parse(amountController.text);

    if (entredTitle.isEmpty || entredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(entredTitle, entredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submet()),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submet(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                        onPressed: _presentDatePicker,
                        child: Text('Choose Date'),
                        textColor: Theme.of(context).primaryColor),
                  ],
                ),
              ),
              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  onPressed: submet),
            ],
          ),
        ),
      ),
    );
  }
}
