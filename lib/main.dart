import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Currency Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currency = 'EUR';
  double amount = 0;
  IconData currencyIcon = Icons.euro;
  double convertedValue = 0;
  Map<String, double> currencyRate = {
    'EUR': 4.97,
    'USD': 4.55,
    'JPY': 0.031,
    'GBP': 5.71,
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title,
              style:
                  const TextStyle(fontWeight: FontWeight.w200, fontSize: 30))),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: 350,
                  height: 200,
                  child: Image.network(
                      'https://mediaflux.ro/wp-content/uploads/strawberry/2023/07/bani-de-la-stat34-c-1000x563.jpg'),
                )),
            Card(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 350,
                height: 150,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        DropdownButton<String>(
                          padding: const EdgeInsets.all(10),
                          underline: Container(
                            height: 0,
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 20),
                          value: currency,
                          onChanged: (String? newValue) {
                            setState(() {
                              currency = newValue!;
                              if (currency == 'USD') {
                                currencyIcon = Icons.attach_money;
                              } else if (currency == 'EUR') {
                                currencyIcon = Icons.euro;
                              } else if (currency == 'GBP') {
                                currencyIcon = Icons.currency_pound_outlined;
                              } else if (currency == 'JPY') {
                                currencyIcon = Icons.currency_yen;
                              }
                            });
                          },
                          items: <String>['USD', 'EUR', 'GBP', 'JPY']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          currencyIcon,
                          size: 35,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: Form(
                              key: _formKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a number!';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter an amount',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 20),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    amount = double.tryParse(value) ?? 0.0;
                                  });
                                },
                                style: const TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 350,
                height: 150,
                child: Column(
                  children: <Widget>[
                    const Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'RON',
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 20,
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              convertedValue.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState!.validate();

                setState(() {
                  convertedValue = amount * currencyRate[currency]!;
                });
              },
              child: const Text('Convert',
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
