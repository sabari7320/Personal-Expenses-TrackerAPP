import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testfiles/widgets/new_transaction.dart';
import 'package:testfiles/widgets/transaction_list.dart';
import './models/transaction.dart';
import 'chart.dart';

void main() {


  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Personal Expenses',
        theme:ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(subtitle1:TextStyle(fontFamily: 'OpenSans',fontSize: 18,fontWeight: FontWeight.bold)),

          appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
        subtitle1:TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),

    )),
        home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'new shoes',
    //   amount: 77.98,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'weekly Groceries',
    //   amount: 67.98,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart=false;

  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }
  List<Transaction> get _recentTransactions{
    return _userTransaction.where((tx)  {
      return tx.date.isAfter
        (DateTime.now().subtract(Duration(days: 7),

      ));
    }).toList();
  }

  void _starAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
     builder:(_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
void _deleteTransaction(String id){
setState(() {
  _userTransaction.removeWhere((tx){
    return tx.id==id;
  });
});
}
  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    final isLandscape =   mediaQuery.orientation== Orientation.landscape;
    final appbar=AppBar(
    title: Text('Personal Expenses',style: TextStyle(fontFamily: 'Open Sans'),),
    actions: [
    IconButton(
    icon: Icon(Icons.add),
    onPressed: () => _starAddNewTransaction(context),
    ),
    ],
    );
    final txListWidget= Container(
        height:(mediaQuery.size.height- appbar.preferredSize.height-mediaQuery.padding.top)*0.7
        ,child:TransactionList(_userTransaction,_deleteTransaction));
    return Scaffold(
     appBar:appbar,
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(isLandscape) Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Show Chart'),
              Switch(value:_showChart, onChanged:(val){
                setState(() {
                  _showChart=val;
                });
              })
            ],),
           if(!isLandscape)  Container(height:(mediaQuery.size.height- appbar.preferredSize.height-
                             mediaQuery.padding.top)*0.3,
                             child: Chart(_recentTransactions)),
          if(!isLandscape) txListWidget,
          if(isLandscape) _showChart?
           Container(height:(mediaQuery.size.height- appbar.preferredSize.height-mediaQuery.padding.top)*0.8,
               child: Chart(_recentTransactions)):txListWidget


          ],
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _starAddNewTransaction(context),
      ),

    );
  }
}
