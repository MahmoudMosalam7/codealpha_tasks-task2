import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home:  QuoteGenerator(),
    );
  }
}
class QuoteGenerator extends StatefulWidget {
  const QuoteGenerator({super.key});

  @override
  State<QuoteGenerator> createState() => _QuoteGeneratorState();
}

class _QuoteGeneratorState extends State<QuoteGenerator> {
  final String postURL = "https://api.adviceslip.com/advice";
  String quote = 'Random Quote';
  generateQuote()async{
    var response = await http.get(Uri.parse(postURL));
    var result = jsonDecode(response.body);
    print(result['slip']['advice']);
    setState(() {
      quote = result['slip']['advice'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Random Quote Generator',style: TextStyle(
            color: Colors.white
        ),),
        actions: [
          IconButton(
            onPressed: (){}, icon: Icon(Icons.generating_tokens,color: Colors.white,),
          ),

        ],

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('One piece of advice can change you',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              )),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text('$quote',style: TextStyle(fontSize: 20,
                    color: Colors.white
                ),),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      generateQuote();
                    }, child: Text('Generate',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),)),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 200, // Set your desired width
                height: 50, // Set your desired height
                child: ElevatedButton(
                  onPressed: () async {
                    await Share.share('I am Happy to Share this advice with you!'
                        ' \n\n$quote \n\n #Random Quote Generator');
                  },
                  child: Text(
                    'Share',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
