import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const  MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _tickerData = '';

  @override
  void initState() {
    super.initState();
    _fetchTickerData();
  }

  Future<void> _fetchTickerData() async {
    final String apiKey = 'GEMINI_API_KEY';
    final String apiSecret = 'GEMINI_API_KEY';
    final String baseUrl = 'https://api.gemini.com';
    final String endpoint = '/v1/pubticker/btcusd';

    final response = await http.get(
      Uri.parse(baseUrl + endpoint),
      headers: {
        'Content-Type': 'application/json',
        'X-GEMINI-APIKEY': apiKey,
        'X-GEMINI-PAYLOAD': _generatePayload(),
        'X-GEMINI-SIGNATURE': _generateSignature(apiSecret),
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _tickerData = json.decode(response.body).toString();
      });
    } else {
      setState(() {
        _tickerData = 'Error al obtener datos';
      });
    }
  }

  String _generatePayload() {
    final payload = {
      'nonce': DateTime.now().millisecondsSinceEpoch,
      // Otros parámetros requeridos por la API, según la documentación de Gemini
    };
    return json.encode(payload);
  }

  String _generateSignature(String apiSecret) {
    // Implementa la generación de la firma utilizando tu apiSecret
    // Consulta la documentación de Gemini para obtener más detalles sobre cómo generar la firma.
    return 'signature'; // Reemplaza esto con tu lógica de generación de firma
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('primera conexion'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Datos:',
              ),
              const SizedBox(height: 20),
              Text(_tickerData),
            ],
          ),
        ),
      ),
    );
  }
}
