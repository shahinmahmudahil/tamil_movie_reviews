
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class PageBusList extends StatefulWidget {
  @override
  _PageBusListState createState() => _PageBusListState();
}

class _PageBusListState extends State<PageBusList> {

  @override
  void initState() {

    ///===Listen to data change at the collection and call the listener function
    Firestore.instance.collection('Articles').snapshots().listen(_onDataChange);

    super.initState();

  }

  void _onDataChange(QuerySnapshot snapshot){
    print(snapshot);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Bus List"),),
      body: Column(
        children: <Widget>[
          Container(),



          RaisedButton(
            onPressed: (){
              ////Set data with unique id
//              Firestore.instance.collection('new').document().setData({'t1': '12s','value':2});
//              ////Set data with a fixed document
//              Firestore.instance.collection('new').document('d1').setData({'t1': '12s','value':2});

              Firestore.instance.collection('buses').document('Raida').setData({'Name': 'Tbjbjburag','tracker_id':5});
            },
            child: Text("Add bus"),
          ),

//          Consumer<Counter>(
//            builder: (context,counter,child) => Text(
//              "${counter.name}",style: TextStyle(fontSize: 28),
//            ),
//          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
//          Provider.of<Counter>(context,listen: false).changeName("Rashed${DateTime.now()}");

        },
        tooltip: "Inrement",
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
