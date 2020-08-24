import '../model/expense.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';

class NewExpenseScreen extends StatefulWidget {
  NewExpenseScreen({Key key, this.expensesLen}) : super(key: key);
  final int expensesLen;
  @override
  _NewExpenseScreenState createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  Category _selectedCategory;
  DateTime curDate = DateTime.now();
  TextEditingController _selectedDate = new TextEditingController();
  TextEditingController _selectedAmount = new TextEditingController(); // _selectedAmount.text is the value
  TextEditingController _selectedItemName = new TextEditingController();

  void _onPressedCategory(Category category) {
    // print(category.name); // debug usage
    setState(() {
      _selectedCategory = category;
    });
  }

  String _formatCategoryName(String name){
    switch(name)
    {
      case "financials":
        return "Financials";
      case "home":
        return "Home";
      case "leisure":
        return "Leisure";
      case "others":
        return "Others";
      default:
        print(name);
        return null;
    }
  }

  // date picker
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: curDate,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2100)
    );

    if (picked != null && picked != curDate)
      setState(() {
        curDate = picked;
        String _day = "${curDate.day}".length > 1 ? "${curDate.day}" : "0${curDate.day}" ;
        String _month = "${curDate.month}".length > 1 ? "${curDate.month}" : "0${curDate.month}" ;

        var date = "${curDate.year}-$_month-$_day";
        _selectedDate.value = TextEditingValue(text: date.toString());
        // print(_selectedDate.text);  // for debug
      }
    );
  }

  @override
  void initState() {
    super.initState();
    print(widget.expensesLen);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Add Expense'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // item name
                  SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueGrey,
                    ),
                    child: Column(children: <Widget>[
                      Text('Item Name', style: TextStyle(color: Colors.white)),
                      SizedBox(height: 12.0),
                      GestureDetector(
                      // Container(
                        // height: 36.0,
                        child: Center(
                        // child: AbsorbPointer(
                          child: TextField(
                            controller: _selectedItemName,
                            decoration: InputDecoration(
                              hintText: 'Movie Ticket',
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            // keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ]),
                  ),

                  // amount
                  SizedBox(height: 24.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    // padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueGrey,
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Amount', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('HKD', style: TextStyle(color: Colors.white)),
                              SizedBox(width: 24.0),
                              Expanded(
                                child: Container(
                                  height: 36.0,
                                  child: Center(
                                    child: TextField(
                                      controller: _selectedAmount,
                                      decoration: InputDecoration(
                                        hintText: '00.00',
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.numberWithOptions(decimal : true),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                        ]),
                  ),

                  // date
                  SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueGrey,
                    ),
                    child: Column(children: <Widget>[
                      Text('Date', style: TextStyle(color: Colors.white)),
                      SizedBox(height: 12.0),
                      GestureDetector(
                      // Container(
                        // height: 36.0,
                        // child: Center(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                          // child: TextField(
                            controller: _selectedDate,
                            decoration: InputDecoration(
                              hintText: 'YYYY-MM-DD',
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.datetime,
                            // keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ]),
                  ),

                  // category
                  SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 8.0),
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueGrey,
                    ),
                    child: Column(children: <Widget>[
                      Text('Category', style: TextStyle(color: Colors.white)),
                      SizedBox(height: 12.0),
                      Row(children: [
                        Expanded(child: Container()),
                        Container(
                          width: (42.0 + 20.0) * 3 + 42.0,
                          child: Wrap(
                            runSpacing: 20.0,
                            spacing: 20.0,
                            children: Category.values.map((e) {
                              final child = Container(
                                width: 42.0,
                                height: 42.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: MaterialButton(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.zero,
                                  onPressed: () => _onPressedCategory(e),
                                  child: Center(
                                    child: e.iconWidget(),
                                  ),
                                ),
                              );
                              return e == _selectedCategory
                                  ? Badge(
                                      size: 8.0,
                                      offset: 1.0,
                                      child: child,
                                    )
                                  : child;
                            }).toList(),
                          ),
                        ),
                        Expanded(child: Container()),
                      ]),
                      SizedBox(height: 8.0),
                    ]),
                  ),

                  // done
                  SizedBox(height: 40.0),
                  Center(
                    child: Container(
                        height: 40.0,
                        child: MaterialButton(
                          child: Text('Done',
                              style: TextStyle(color: Colors.white)),
                          shape: StadiumBorder(),
                          color: Colors.blueGrey,
                          onPressed: () {
                            /// Pass the expense data to Home Screen
                            Expense _newExpense = new Expense();
                            _newExpense.name = _selectedItemName.text;
                            _newExpense.amount = double.parse(_selectedAmount.text);
                            _newExpense.createdAt = _selectedDate.text;
                            _newExpense.category = _formatCategoryName(_selectedCategory.name);
                            _newExpense.recordId = (widget.expensesLen + 1).toString();
                            Navigator.of(context).pop(_newExpense);
                          },
                        )),
                  ),

                ]),
          ),
        ));
  }
}

class Badge extends StatelessWidget {
  final Widget child;
  final dynamic offset;
  final double size;
  final Color color;

  const Badge({
    Key key,
    @required this.child,
    this.offset = 0.0,
    this.size = 11.0,
    this.color = const Color(0xFF33D176),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.visible, children: <Widget>[
      child,
      Positioned(
        top: offset is Offset ? offset.dy : offset,
        right: offset is Offset ? offset.dx : offset,
        width: size,
        height: size,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    ]);
  }
}
