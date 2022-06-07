import 'package:flutter/material.dart';

import 'network/random_number_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _randomNumber = "";
  List<String> randomNumberList = [];

  Future<void> _getRandomNumber() async {
    int randomNumber = await RandomNumberApi.fetchRandomNumber();
    randomNumberList.add(randomNumber.toString());
    setState(() {
      _randomNumber = randomNumber.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 60.0,
            ),
            ElevatedButton(
              // style: raisedButtonStyle,
              onPressed: _getRandomNumber,
              child: const Text('Get New Random Number'),
            ),

            const SizedBox(
              height: 50.0,
            ),

            Text(
              _randomNumber,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 40.0,
            ),
            Text(
              'Previous Numbers',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // Let the ListView know how many items it needs to build.
              itemCount: randomNumberList.length,
              itemBuilder: (context, index) {
                final item = randomNumberList[index];

                return ListTile(
                  title: Center(
                    child: Text(item),
                  )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}