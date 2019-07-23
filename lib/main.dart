import 'package:flutter/material.dart';
import'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: true,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600]
    ),
    home: MyApp(),
    
  ),
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  String name,description;
double price;

  getName(name){
    this.name=name;
    print(this.name);
  }

  getDescription(description){
    this.description=description;
    print(this.description);
  }

  getPrice(price){
    this.price=  double.parse(price);
    print(this.price);
  }

  createDate(){
    DocumentReference documentReference=Firestore.instance.collection('Dishes').document(name);
   Map<String , dynamic> dish={
     "name" :name,
     "description" :description,
     "price" :price,

  };
   documentReference.setData(dish).whenComplete((){
     print("$name created");
   });
  }


  readeDate(){
    DocumentReference documentReference=Firestore.instance.collection('Dishes').document(name);

    documentReference.get().then((datasnapshot){
     print(datasnapshot.data["name"]);
     print(datasnapshot.data["description"]);
     print(datasnapshot.data["price"]);
    });
  }

  updateDate(){
    DocumentReference documentReference=Firestore.instance.collection('Dishes').document(name);
    Map<String , dynamic> dish={
      "name" :name,
      "description" :description,
      "price" :price,

    };
    documentReference.setData(dish).whenComplete((){
      print("$name upadted");
    });
  }



  deleteDate(){
    DocumentReference documentReference=Firestore.instance.collection('Dishes').document(name);
    documentReference.delete().whenComplete((){
      print("$name deleted");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tim Course'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(1.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'name',
              ),
              onChanged: (String name){
                getName(name);
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Describtion',
              ),
              onChanged: (String description){
                getDescription(description);
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'price',
              ),
              onChanged: (String name){
                getPrice(price);
              },
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right:1.0),
                    child: RaisedButton(
                        color: Colors.green,
                        child: Text("Create"),
                        onPressed:(){
                                   createDate();
                        } ,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right:1.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("Read"),
                      onPressed:(){
                        readeDate();
                      } ,
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(right:1.0),
                    child: RaisedButton(
                      color: Colors.orange,
                      child: Text("Update"),
                      onPressed:(){
                        updateDate();
                      } ,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right:1.0),
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text("Delete"),
                      onPressed:(){
                        deleteDate();
                      } ,
                    ),
                  ),

                ],
              ),


            ),

            Row( textDirection: TextDirection.ltr,
              children: <Widget>[
                Expanded(
                  child:  Text("name"),
                ),
                Expanded(
                  child:  Text("description"),
                ),
                Expanded(
                  child:  Text("price"),
                ),
              ],
            ),
            Divider(height: 12.0,color: Colors.white,),

            StreamBuilder(stream: Firestore.instance.collection("Dishes").snapshots(),
            builder: (context, snapshot){
//              if(snapshot.hasData){
//return ListView.builder(
//  shrinkWrap: true,
//  itemCount: snapshot.data. documents.length,
//  itemBuilder:(context , index){
//    DocumentSnapshot ds = snapshot.data. documents[index];
//    return Row(
//      textDirection: TextDirection.ltr,
//      children: <Widget>[
//        Expanded(
//          child:  Text(ds["name"]),
//        ),
//        Expanded(
//          child:  Text(ds["description"]),
//        ),
//        Expanded(
//          child:  Text(ds["price"].toString()),
//        ),
//
//      ],
//    );
//  } ,
//
//);
//
//              }
              return ListView.builder(
                            shrinkWrap: true,
                  itemCount: snapshot.data. documents.length,
                  itemBuilder:(context , index){
                   DocumentSnapshot ds = snapshot.data. documents[index];
                   return Row(
                     textDirection: TextDirection.ltr,
                     children: <Widget>[
                      Expanded(
                        child:  Text(ds["name"]),
                      ),
                       Expanded(
                         child:  Text(ds["description"]),
                       ),
                       Expanded(
                         child:  Text(ds["price"].toString()),
                       ),

                     ],
                   );
                  } ,
                  );

            },
            ),
          ],
        ),
      ),
    );
  }
}

