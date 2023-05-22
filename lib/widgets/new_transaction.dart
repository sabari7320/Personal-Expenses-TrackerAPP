import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {

  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}
class _NewTransactionState extends State<NewTransaction>{
  final _titleController=TextEditingController();
  final _amountController=TextEditingController();
  DateTime _selectedDate=DateTime.now();



  void _submitdata(){
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle=_titleController.text;
    final enteredAmount=double.parse(_amountController.text);
    if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate==null){
      return;
    }
    widget.addTx(enteredTitle,enteredAmount,_selectedDate);
    Navigator.of(context).pop();

  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate:DateTime.now(),


    ).then((pickDate){
      if(pickDate==null){
        return;
      }
      setState(){
        _selectedDate=pickDate;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 1,left: 10,right: 10,bottom:MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(decoration: InputDecoration(labelText: 'Title'),
                keyboardType: TextInputType.text,
                controller:_titleController,
                onSubmitted:(_)=>_submitdata ,
                ),

              TextField(decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted:(_)=>_submitdata ,
               ),
              Container(
                height: 70,

                child: Row(
                  children: [
                  Expanded(child:Text(_selectedDate ==null ?'No Data Chosen !':'Picked Date:${DateFormat.yMd().format(_selectedDate)}',),),

                    TextButton(onPressed:_presentDatePicker, child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                ),
              ),
              ElevatedButton(onPressed:_submitdata, child: Text('Add Transaction',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),)
            ],
          ),
        ),),
    );
  }
}
