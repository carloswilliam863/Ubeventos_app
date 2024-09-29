import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  final String baseUrl = 'http://127.0.0.1:8000/api'; 

  // Obter token do SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Listar todos os produtos
  Future<List<dynamic>> fetchProducts() async {
    String? token = await getToken();
    
    if (token == null) {
      throw Exception('Token não encontrado. O usuário pode não estar autenticado.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/products'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // A resposta deve estar em formato de JSON com a chave "data"
      final responseData = jsonDecode(response.body);
      return responseData['data'] ?? [];
    } else {
      throw Exception('Erro ao carregar produtos: ${response.body}');
    }
  }

  // Criar novo produto
Future<void> addProduct(String nome, String preco, String categoria, int quantidadeEmEstoque, String fornecedor) async {
  String? token = await getToken();
  final response = await http.post(
    Uri.parse('$baseUrl/products'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'nome': nome,
      'preco': preco,
      'categoria': categoria,
      'quantidadeEmEstoque': quantidadeEmEstoque,
      'fornecedor': fornecedor,
    }),
  );
  if (response.statusCode == 201) {
    print('Produto adicionado com sucesso');
  } else {
    throw Exception('Erro ao adicionar produto');
  }
}


  // Atualizar produto
  Future<void> updateProduct(int id, String nome, String preco) async {
    String? token = await getToken();

    if (token == null) {
      throw Exception('Token não encontrado. O usuário pode não estar autenticado.');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
        'preco': preco,
      }),
    );

    if (response.statusCode == 200) {
      print('Produto atualizado com sucesso');
    } else {
      throw Exception('Erro ao atualizar produto: ${response.body}');
    }
  }

  // Deletar produto
  Future<void> deleteProduct(int id) async {
    String? token = await getToken();

    if (token == null) {
      throw Exception('Token não encontrado. O usuário pode não estar autenticado.');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/products/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Produto deletado com sucesso');
    } else {
      throw Exception('Erro ao deletar produto: ${response.body}');
    }
  }
}
