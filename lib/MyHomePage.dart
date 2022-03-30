

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String input = "";
  String output = "";
  final textFieldController = TextEditingController();

  void handleChange() {
    setState(() {
      input = textFieldController.text;
    });
  }

  void convert() {
    if (_errorText == null) {
      setState(() {
        output = (4.95 * double.parse(input)).toString();
      });
    }
  }

  String? get _errorText {
    final text = textFieldController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    try {
      double.parse(input);
    } catch (exception) {
      return 'Invalid input';
    }
    // return null if the text is valid
    return null;
  }

  @override
  void initState() {
    super.initState();
    textFieldController.addListener(handleChange);
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: textFieldController,
      builder: (context, TextEditingValue value, __) {
        // this entire widget tree will rebuild every time
        // the controller value changes
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.network(
                      "https://media.istockphoto.com/photos/for-the-love-of-money-iv-picture-id182658735?k=20&m=182658735&s=170667a&w=0&h=2rOiOoN3z7x9Jx3JP8Go7NZenwo95YazlLM91VcnU_Q="),
                  TextField(
                    controller: textFieldController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter amount',
                      // use the getter variable defined above
                      errorText: _errorText,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(25),
                    child: TextButton(
                      child: Text(
                        'Convert', style: TextStyle(fontSize: 20.0),),
                      onPressed: () {
                        convert();
                      },
                    ),
                  ),
                  Text(
                    '$output',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}