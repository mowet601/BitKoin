import 'package:flutter/material.dart';
import 'dart:convert';
import 'currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Currencylist extends StatefulWidget{
	@override
  CurrencyListState createState() => new CurrencyListState();
}

class CurrencyListState extends State <Currencylist>{
  static final String routeName = '/currency';

  void _savePrefs( String coin, description ) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setString('coin', coin);
    prefs.setString('coinDescription', description );
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
			appBar: new AppBar(
				title: new Text('Set currency'),
			),
			body: new Center(
        child: new FutureBuilder(
          future: DefaultAssetBundle
            .of(context)
            .loadString('JSON/currencies.json'),
          builder: (context, snapshot){
            //Decode JSON
            var myData = json.decode(snapshot.data.toString());

            return new ListView.builder(
              itemCount: myData == null ? 0 : myData.length,
              itemBuilder: (BuildContext context, int index){
                      return new Column(
												children: <Widget>[
													new ListTile(
                        		title: new Text(myData[index]['currency']+ "-" + myData[index]['country']),
                         		onTap:(){
                               _savePrefs(myData[index]['currency'], myData[index]['country']); //saves default currency.

                            	var currencyChosen = new Currency(myData[index]['currency'], myData[index]['country']); //prepares object that will be returned through Navigator.pop command

                            	Navigator.of(context).pop(currencyChosen);
                         		}
													),
													new Divider()
												]
											);
              }
            );
          }
        )
      )
    );
  }
}