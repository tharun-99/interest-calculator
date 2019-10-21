import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'simple interest calculator',
    home: SIform(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIform> {
  var currencies = ['Rupees', 'Dollars', 'Pounds'];
  final minPadding = 5.0;
  var currentItemSelected = 'Rupees';
  var formKey = GlobalKey<FormState>();
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Interest Calculator',
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(minPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (String value){
                    if(value.isEmpty){
                      return'Please enter principal amount';
                    }
                  },
                  style: textStyle,
                  controller: principalController,
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter principal e.g 12000',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (String value){
                    if(value.isEmpty){
                      return'Please enter interest';
                    }
                  },
                  style: textStyle,
                  controller: roiController,
                  decoration: InputDecoration(
                      labelText: 'Interest',
                      hintText: 'In Percent e.g 10',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: minPadding, bottom: minPadding),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (String value){
                            if(value.isEmpty){
                              return'Please enter term';
                            }
                          },
                          style: textStyle,
                          controller: termController,
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Term In Years',
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,fontSize: 15.0,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                    ),
                    Container(
                      width: minPadding * 2,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                          items: currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: currentItemSelected,
                          onChanged: (String newValueSelected) {
                            onDropDownItemSelected(newValueSelected);
                          }),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if(formKey.currentState.validate())
                            this.displayResult = calculateTotalReturns();
                          }); //onpressed code for calculate here
                        },
                      ),
                    ),
                    Container(
                      width: minPadding * 2,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            resetData();
                          });
                          //onpressed code for reset here
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: minPadding),
                child: Text(
                  this.displayResult, style: textStyle,
                  //result will be displayed here
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(minPadding * 10),
    );
  }

  void onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.currentItemSelected = newValueSelected;
    });
  }

  String calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    int term = int.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years your investment will be worth $totalAmountPayable $currentItemSelected';
    return result;
  }

  void resetData() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    currentItemSelected = currencies[0];
  }
}
