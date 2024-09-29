import 'package:flutter/material.dart';
import 'package:ubeventos_app/services/venda_service.dart';


class VendaScreen extends StatefulWidget {
  const VendaScreen({super.key});

  @override
  _VendaScreenState createState() => _VendaScreenState();
}

class _VendaScreenState extends State<VendaScreen> {
  List<dynamic> _vendas = [];
  final VendaService _vendaService = VendaService();

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendas')),
      body: ListView.builder(
        itemCount: _vendas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Cliente: ${_vendas[index]['cliente']['nome']}'),
            subtitle: Text('Total: \$${_vendas[index]['total']}'),
          );
        },
      ),
    );
  }
}
