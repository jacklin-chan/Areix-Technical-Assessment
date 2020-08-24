import 'package:flutter/material.dart' hide Actions;

import '../model/expense.dart';
import 'new_expense.dart';

List<Expense> expenses = new List<Expense>();
List<Expense> filteredExpense = new List<Expense>();
bool isFiltered = false;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Areix Ledger'),
        actions: <Widget>[SettingsButton()],
      ),
      body: Transactions(context),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FilterMonthButton(context),
          SizedBox(height: 10.0),
          SortButton(context),
          SizedBox(height: 10.0),
          FilterButton(context),
          SizedBox(height: 10.0,),
          AddTransactionButton(context),
        ]
      )
    );
  }
}

class Transactions extends StatefulWidget {
  Transactions(this.tmp);
  final BuildContext tmp;

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    // Transaction transactions = new Transaction('2020-02-02','txn 1',List<Posting>());
    // List<Expense> expenses = new List<Expense>();
    // expenses = [
    //   new Expense(recordId:'1',name:'Dinning in McD', amount:121.3,category:'Home',createdAt:'2020-02-02'),
    //   new Expense(recordId:'2',name:'Shopping in the mall', amount:314.3,category:'Financials',createdAt:'2020-02-12'),
    //   new Expense(recordId:'3',name:'Pay for tax', amount:1545.3,category:'Leisure',createdAt:'2020-02-03'),
    //   new Expense(recordId:'4',name:'jacklin', amount:1545.3,category:'Leisure',createdAt:'2020-02-01'),
    // ];

    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 1.0,
          child: RefreshIndicator(
            onRefresh: () async {
              (widget.tmp as Element).markNeedsBuild();
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: isFiltered? filteredExpense.length :
                          expenses.length, // transactions.length
              itemBuilder: (BuildContext context, int index) => new Padding(
                padding: EdgeInsets.fromLTRB(4, (index == 0) ? 8 : 0, 4,
                    (index == (isFiltered? filteredExpense.length -1 : expenses.length - 1)) ? 8 : 0),
                child: Card(
                  color: Colors.blueGrey,
                  elevation: 3,
                  child: InkWell(
                    onTap: () => {
                      // print(expenses[index].recordId)
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: FormattedJournalItem(
                        expense: isFiltered? filteredExpense[index] : expenses[index],
                        dark: Theme.of(context).brightness == Brightness.dark,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FormattedJournalItem extends StatelessWidget {
  const FormattedJournalItem({@required this.expense, @required this.dark});

  final Expense expense;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    Widget formattedJournalItem;
      final Color color = Colors.white;

    if (expense is Expense) {
      final String date = expense.createdAt;
      final String name = expense.name;
      final String category = expense.category;
      final double amount = expense.amount;
      final Widget column = Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FormatString(
                text: date,
                color: color,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // const FormatString(text: ' '),
                          SizedBox(width: 20,),
                          FormatString(
                            text: name,
                            color: color,
                          ),
                          // const FormatString(text: '   '),
                          SizedBox(width: 20,),
                          FormatString(
                            text: '\$',
                            color: color,
                          ),
                          FormatString(
                            text: amount.toString(),
                            color: color,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const FormatString(text: ' '),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const FormatString(text: ' '),
                          FormatString(
                            text: category,
                            color: color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
      formattedJournalItem = column;
    }
    return formattedJournalItem;
  }
}

class FormatString extends StatelessWidget {
  const FormatString({@required this.text, this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
      ),
      style: TextStyle(
        // fontFamily: 'IBMPlexMono',
        color: color,
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('Settings'),
      icon: const Icon(Icons.settings),
      onPressed: () {
        // Navigator.pushNamed(context, '/settings');
        print('navigate to setting');
      },
    );
  }
}

class FilterMonthButton extends StatelessWidget {
  FilterMonthButton(this.tmp);
  final BuildContext tmp;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text('Choose the desired month'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "1"
                    ).toList();
                  print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("January"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "2"
                    ).toList();
                  // print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("February"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "3"
                    ).toList();
                  print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("March"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "4"
                    ).toList();
                print(filteredExpense);
                isFiltered = true;
                Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("April"),
                )
              ),SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "5"
                    ).toList();
                  print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("May"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "6"
                    ).toList();
                  // print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("June"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "7"
                    ).toList();
                  print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("July"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "8"
                    ).toList();
                print(filteredExpense);
                isFiltered = true;
                Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("August"),
                )
              ),SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "0" && expense.createdAt[6] == "9"
                    ).toList();
                  print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("September"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "1" && expense.createdAt[6] == "0"
                    ).toList();
                  // print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("October"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "1" && expense.createdAt[6] == "1"
                    ).toList();
                  print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("November"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                filteredExpense = expenses.where(
                    (expense) => expense.createdAt[5] == "1" && expense.createdAt[6] == "2"
                    ).toList();
                print(filteredExpense);
                isFiltered = true;
                Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("December"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                isFiltered = false;
                Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("Reset"),
                )
              ),
            ]
          ),
        );
        (tmp as Element).markNeedsBuild();
      },
      child: const Icon(Icons.access_time)
    );
  }
}

class SortButton extends StatelessWidget {
  SortButton(this.tmp);
  final BuildContext tmp;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text('Sort By'),
            children: <Widget>[
              //  sort by 'created at'
              SimpleDialogOption(
                onPressed: () {
                  expenses.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                  Navigator.of(context).pop(true);
                  (tmp as Element).markNeedsBuild();  // update the screen
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("Created at"),
                )
              ),
            ]
          ),
        );
        expenses.forEach((element) {
                    print(element.toJson());
                  });
        (tmp as Element).markNeedsBuild();
      },
      child: const Icon(Icons.sort),
    );
  }
}

class FilterButton extends StatelessWidget {
  FilterButton(this.tmp);
  final BuildContext tmp;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text('Filtered By'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where((expense) => expense.category == "Home").toList();
                  print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("Home"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where((expense) => expense.category == "Financials").toList();
                  // print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("Financials"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                  filteredExpense = expenses.where((expense) => expense.category == "Leisure").toList();
                  print(filteredExpense);
                  isFiltered = true;
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("Leisure"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                filteredExpense = expenses.where((expense) => expense.category == "Others").toList();
                print(filteredExpense);
                isFiltered = true;
                Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("Others"),
                )
              ),
              SimpleDialogOption(
                onPressed: () {
                isFiltered = false;
                Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("Reset"),
                )
              ),
            ]
          ),
        );
        (tmp as Element).markNeedsBuild();
      },
      child: const Icon(Icons.filter),
    );
  }
}

class AddTransactionButton extends StatelessWidget {
  AddTransactionButton(this.tmp);
  final BuildContext tmp;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: '''the only floating action button here ${DateTime.now().millisecondsSinceEpoch}''',
      onPressed: () {
        print('FloatingActionButton got pressed');
        // Navigator.pushNamed<dynamic>(context, '/new_expense');
        print(expenses.length);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewExpenseScreen(expensesLen: expenses.length)
          ),
        ).then((value) {
          expenses.add(value);
          expenses.forEach((e) => print(e.toJson()));
          (tmp as Element).markNeedsBuild();
        });
      },
      child: const Icon(Icons.add),
    );
  }
}
