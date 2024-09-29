import 'package:flutter/material.dart';
import 'package:ubeventos_app/services/product_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<dynamic> _products = [];
  final ProductService _productService = ProductService();

  final Color backgroundColor = const Color(0xFF50285B); // Roxo escuro do topo
  final Color cardColor = const Color(0xFFB28FC5); // Roxo claro dos cards
  final Color textColor = Colors.white; // Branco para o texto

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // Fundo roxo escuro
       appBar: AppBar(
        backgroundColor: Colors.purple, // Cor de fundo roxa
        title: Row(
          children: [
             Image.asset(
                'images/gatitologo.png', 
                width: 100,
              ),
              SizedBox(width: 20),
            const Text(
              'PRODUTOS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Cor do texto
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          String? imageUrl = _products[index]['imagem'];

          return Card(
            color: cardColor, // Card roxo claro
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image),
                        );
                      },
                    )
                  else
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _products[index]['nome'] ?? 'Nome indisponível',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor, // Texto branco
                          ),
                        ),
                        Text(
                          'Categoria: ${_products[index]['categoria'] ?? 'Indisponível'}',
                          style: TextStyle(color: textColor), // Texto branco
                        ),
                        Text(
                          'Marca: ${_products[index]['fornecedor'] ?? 'Indisponível'}',
                          style: TextStyle(color: textColor), // Texto branco
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      _products[index]['quantidade'] != null
                          ? _products[index]['quantidade'].toString()
                          : 'Indisponível',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor, // Texto branco
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor, // Fundo do BottomNavigationBar
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.white),
            label: 'Produtos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            label: 'Vendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory, color: Colors.white),
            label: 'Pedidos Entrada',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          // Implementar a lógica de navegação entre páginas
        },
      ),
    );
  }
}
