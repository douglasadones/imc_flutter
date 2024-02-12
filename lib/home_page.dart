import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double imcResult = 0.0;

  void calclulateImc({required double weight, required double height}) {
    final double imc = weight / (height * height);

    setState(() {
      imcResult = imc;
    });
  }

  void clearResult() {
    setState(() {
      imcResult = 0.0;
      heightController.clear();
      weightController.clear();
    });
  }

  String imcCategory({required double imcResult}) {
    if (imcResult < 1) {
      return '';
    } else if (imcResult >= 1 && imcResult < 18.5) {
      return 'Baixo peso';
    } else if (imcResult >= 18.5 && imcResult <= 24.0) {
      return 'Peso normal';
    } else if (imcResult >= 25.0 && imcResult <= 29.9) {
      return 'Sobrepeso';
    } else if (imcResult >= 30.0 && imcResult <= 34.9) {
      return 'Obesidade Grau I';
    } else if (imcResult >= 35 && imcResult <= 39.0) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.primary, // tive que ver no pdf
        foregroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Calculadora de IMC',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textInputAction: TextInputAction.next,
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Peso'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Altura'),
                onSubmitted: (value) {
                  if (weightController.text.isNotEmpty &&
                      heightController.text.isNotEmpty) {
                    calclulateImc(
                      weight: double.parse(weightController.text),
                      height: double.parse(heightController.text),
                    );
                    FocusManager.instance.primaryFocus
                        ?.unfocus(); // Não conhecia
                  }
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 139, 80, 0),
                    ),
                  ),
                  onPressed: () {
                    if (weightController.text.isNotEmpty &&
                        heightController.text.isNotEmpty) {
                      calclulateImc(
                        weight: double.parse(weightController.text),
                        height: double.parse(heightController.text),
                      );
                      FocusManager.instance.primaryFocus
                          ?.unfocus(); // Não conhecia
                    }
                  },
                  child: const Text(
                    'CALCULAR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              imcResult > 1.0
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3), // tive que ver no pdf
                      ),
                      child: Column(
                        children: [
                          const Text('Resultado'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            imcResult.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 35.0),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            imcCategory(imcResult: imcResult),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              imcResult > 1.0
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 249, 242, 242)),
                        ),
                        onPressed: () => clearResult(),
                        child: const Text(
                          'LIMPAR',
                          style:
                              TextStyle(color: Color.fromARGB(255, 139, 80, 0)),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
