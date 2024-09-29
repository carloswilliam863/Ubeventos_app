import 'package:flutter/material.dart';
import 'package:ubeventos_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); 
  bool _rememberMe = false; // Variável para controlar o estado do checkbox

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await _authService.login(email, password);
      // Navegar para a próxima tela, por exemplo, a tela principal de produtos
      Navigator.pushReplacementNamed(context, '/produtos');
    } catch (e) {
      // Tratar erro de login (exibir mensagem, etc.)
      print('Erro ao fazer login: $e');
      // Você pode exibir uma mensagem de erro usando um Snackbar, por exemplo.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao fazer login: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 2, 65), 
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/gatito.png', 
                height: 150, 
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController, // Associando ao controlador de email
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController, // Associando ao controlador de senha
                obscureText: true, // Oculta a senha
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor : Colors.white,
                  foregroundColor : Colors.purple,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ), // Chama a função de login
                child: const Text('LOGIN'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text('Lembrar-me'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Lógica de registro (talvez abrir outra tela)
                    },
                    child: const Text('Registre-se'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Lógica de esquecimento de senha (talvez abrir outra tela)
                    },
                    child: const Text('Esqueceu a senha?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



