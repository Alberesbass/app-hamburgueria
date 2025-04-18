import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const HamburgueriaZApp());
}

class HamburgueriaZApp extends StatelessWidget {
  const HamburgueriaZApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HamburgueriaZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      home: const PedidoPage(),
    );
  }
}

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key});

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  final TextEditingController _nomeController = TextEditingController();
  int _quantidade = 1;
  double _precoBase = 20.00; // Preço base atualizado para R$20
  double _precoTotal = 20.00;
  
  // Adicionais com preços específicos
  final Map<String, double> _adicionais = {
    'Bacon': 2.00,
    'Queijo': 2.00,
    'Onion Rings': 3.00,
  };
  
  final Map<String, bool> _adicionaisSelecionados = {};

  @override
  void initState() {
    super.initState();
    for (var adicional in _adicionais.keys) {
      _adicionaisSelecionados[adicional] = false;
    }
    _calcularTotal();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _somarQuantidade() {
    setState(() {
      _quantidade++;
      _calcularTotal();
    });
  }

  void _subtrairQuantidade() {
    if (_quantidade > 1) {
      setState(() {
        _quantidade--;
        _calcularTotal();
      });
    }
  }

  void _calcularTotal() {
    double totalAdicionais = 0.0;
    
    _adicionaisSelecionados.forEach((adicional, selecionado) {
      if (selecionado) {
        totalAdicionais += _adicionais[adicional]!;
      }
    });
    
    setState(() {
      _precoTotal = (_precoBase + totalAdicionais) * _quantidade;
    });
  }

  String _formatarResumoPedido() {
    return '''
Nome do cliente: ${_nomeController.text.isEmpty ? "Não informado" : _nomeController.text}
Tem Bacon? ${_adicionaisSelecionados['Bacon'] ?? false ? 'Sim' : 'Não'}
Tem Queijo? ${_adicionaisSelecionados['Queijo'] ?? false ? 'Sim' : 'Não'}
Tem Onion Rings? ${_adicionaisSelecionados['Onion Rings'] ?? false ? 'Sim' : 'Não'}
Quantidade: $_quantidade
Preço final: R\$${_precoTotal.toStringAsFixed(2)}
''';
  }

  Future<void> _enviarPedido() async {
    if (_nomeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, informe seu nome')),
      );
      return;
    }

    final resumo = _formatarResumoPedido();
    
    // Mostrar resumo no app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pedido enviado!\n$resumo')),
    );

    // Enviar por e-mail
    final emailUri = Uri(
      scheme: 'mailto',
      path: 'hamburgueriaz@example.com',
      queryParameters: {
        'subject': 'Pedido de ${_nomeController.text}',
        'body': resumo,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o aplicativo de e-mail')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HamburgueriaZ'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner com logo
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'LOGO HAMBURGUERIAZ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Título
            Text(
              'FAÇA SEU PEDIDO',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            // Campo para nome do cliente
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Seção de adicionais
            Text(
              'ADICIONAIS:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            
            const SizedBox(height: 8),
            
            // Lista de checkboxes para adicionais
            Column(
              children: _adicionais.keys.map((adicional) {
                return CheckboxListTile(
                  title: Text('$adicional (R\$${_adicionais[adicional]!.toStringAsFixed(2)})'),
                  value: _adicionaisSelecionados[adicional],
                  onChanged: (bool? value) {
                    setState(() {
                      _adicionaisSelecionados[adicional] = value!;
                      _calcularTotal();
                    });
                  },
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Controle de quantidade
            Text(
              'QUANTIDADE:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            
            const SizedBox(height: 8),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _subtrairQuantidade,
                ),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$_quantidade',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _somarQuantidade,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Resumo do pedido
            Text(
              'RESUMO DO PEDIDO:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            
            const SizedBox(height: 8),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Cliente: ${_nomeController.text.isEmpty ? "Não informado" : _nomeController.text}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'Tem Bacon? ${_adicionaisSelecionados['Bacon'] ?? false ? 'Sim' : 'Não'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'Tem Queijo? ${_adicionaisSelecionados['Queijo'] ?? false ? 'Sim' : 'Não'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'Tem Onion Rings? ${_adicionaisSelecionados['Onion Rings'] ?? false ? 'Sim' : 'Não'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'Quantidade: $_quantidade',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      'TOTAL: R\$${_precoTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Botão para enviar pedido
            ElevatedButton(
              onPressed: _enviarPedido,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'ENVIAR PEDIDO',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}