
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
 final List<Transaction>transactions;
 final Function deleteTx;
 TransactionList(this.transactions,this.deleteTx);




  @override
  Widget build(BuildContext context) {
    return   Container(
      height:MediaQuery.of(context).size.height*0.6,

      child:transactions.isEmpty ?LayoutBuilder(builder: (ctx,constraints){

        return Column(children: [
        Text('No transactions added yet !',style:
        Theme.of(context).textTheme.subtitle1,
        ),
        Image.asset('assets/images/t.jpg',fit: BoxFit.cover,)

      ]); })
      : ListView.builder(
        itemBuilder: (ctx ,index){
          return  Card(
           elevation: 5,
            margin: EdgeInsets.symmetric(vertical:8 ,horizontal:5 ),
            child:ListTile(leading: CircleAvatar(
             radius: 30,

            child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(child:Text('\u{20B9}${transactions[index].amount}'),),
          ),


          ),
            title:  Text(transactions[index].title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            subtitle: Text(DateFormat().add_yMMMd().format(transactions[index].date),style: TextStyle(color: Colors.grey),),
              trailing: MediaQuery.of(context).size.width > 460
                  ? TextButton.icon(
                  icon:Icon(Icons.delete),
                  label: Text('Delete',style: TextStyle(color: Theme.of(context).errorColor,),),
                  onPressed: ()=>deleteTx(transactions[index].id),


              )
                  :IconButton(icon: Icon(Icons.delete),color: Theme.of(context).errorColor,

              onPressed:()=>deleteTx(transactions[index].id),),
          ),);
        },
        itemCount: transactions.length,

      ),

    );
  }
}
