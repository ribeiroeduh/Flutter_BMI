import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyBMI(),
      ),
    );
  }
}

class MyBMI extends StatefulWidget {
  @override
  _MyBMIState createState() => _MyBMIState();
}

class _MyBMIState extends State<MyBMI> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  String bmiResult = '';
  double bmi = 0.0;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF7EC19D),
          automaticallyImplyLeading: false,
          title: Text(
            'Calculadora de IMC',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMaleSelected = true;
                            isFemaleSelected = false;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: isMaleSelected ? Color(0xFF7EC19D) : Colors.white,
                            //border: isMaleSelected ? Border.all(color: Colors.black, width: 2.0) : null,
                            borderRadius: BorderRadius.circular(250),
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.male,
                                      size: 60,
                                      color: isMaleSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Masculino',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: isMaleSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMaleSelected = false;
                            isFemaleSelected = true;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: isFemaleSelected ? Color(0xFF7EC19D) : Colors.white,
                            //border: isFemaleSelected ? Border.all(color: Colors.black, width: 2.0) : null,
                            borderRadius: BorderRadius.circular(250),
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.female,
                                      size: 60,
                                      color: isFemaleSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Feminino',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: isFemaleSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite o seu peso';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Peso (kg)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite a sua altura';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Altura (cm)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    double weight = double.parse(_weightController.text);
                    double height = double.parse(_heightController.text) / 100.0;
                    setState(() {
                      bmi = weight / (height * height);
                      if (bmi < 18.5) {
                        bmiResult = 'Abaixo do peso';
                      } else if (bmi >= 18.5 && bmi < 24.9) {
                        bmiResult = 'Peso normal';
                      } else if (bmi >= 24.9 && bmi < 29.9) {
                        bmiResult = 'Sobrepeso';
                      } else {
                        bmiResult = 'Obesidade';
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF7EC19D),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Calcule o seu IMC',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Container(
                width: 390,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Seu IMC é ${bmi.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        bmiResult,
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
