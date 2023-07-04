// 
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrossel de Cards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Altera a tela inicial para a tela de login
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Aqui você pode fazer a validação do login com email e senha
    // ...

    if (_isValidLogin(email, password)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro de Login'),
            content: Text('E-mail ou senha inválidos. Por favor, tente novamente.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool _isValidLogin(String email, String password) {
    // Aqui você pode realizar a validação do login
    // Por exemplo, verificar se o email e senha correspondem a um usuário válido
    return email == 'usuario@example.com' && password == 'senha';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> cardContents = [
    'Conteúdo escrito do Card 1',
    'Conteúdo escrito do Card 2',
    'Conteúdo escrito do Card 3',
  ];

  int _currentCardIndex = 0;
  late PageController _pageController;

  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentCardIndex);
    _textEditingController =
        TextEditingController(text: cardContents[_currentCardIndex]);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _goToPreviousCard() {
    if (_currentCardIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentCardIndex--;
        _textEditingController.text = cardContents[_currentCardIndex];
      });
    }
  }

  void _goToNextCard() {
    if (_currentCardIndex < cardContents.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentCardIndex++;
        _textEditingController.text = cardContents[_currentCardIndex];
      });
    }
  }

  void _updateCardContent(String value) {
    setState(() {
      cardContents[_currentCardIndex] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrossel de Cards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentCardIndex = index;
                    _textEditingController.text =
                        cardContents[_currentCardIndex];
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        cardContents[index],
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  );
                },
                itemCount: cardContents.length,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textEditingController,
                onChanged: (value) {
                  _updateCardContent(value);
                },
                decoration: InputDecoration(
                  labelText: 'Novo conteúdo do card',
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _goToPreviousCard,
                  child: Text('Voltar'),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: _goToNextCard,
                  child: Text('Avançar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
