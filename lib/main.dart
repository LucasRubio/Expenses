import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './components/transaction_list.dart';
import './components/chart.dart';
import './models/transaction.dart';
import 'package:intl/date_symbol_data_local.dart';


// main que roda o app
void main() => 
  initializeDateFormatting('pt-br', null).then((_) {
    runApp(ExpensesApp());
  });


// classe que cria o app
class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});

  // tema do app
  final ThemeData tema = ThemeData();

  @override

  // widget que cria o app
  Widget build(BuildContext context) {
    // retorna o Materialapp
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),// widget que cria a tela inicial
      theme: ThemeData(// tema do app
        fontFamily: 'Quicksand',
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.amber,
          primary: Colors.purple,
          secondary: Colors.amber,
          error: Colors.red
        ),
        appBarTheme: AppBarTheme(// tema do appbar
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
// classe que cria a tela inicial
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();// cria o estado da tela
}
// estado da tela inicial
class _MyHomePageState extends State<MyHomePage> {
  // lista de transações
  final List<Transaction> _transactions = [
    /*Transaction(
      id: 't0',
      title: 'Old',
      value: 200.00,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Agua',
      value: 80.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Assinatura Netflix',
      value: 45.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't4',
      title: 'Kirk Hammet',
      value: 210.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't5',
      title: 'Biruleibe',
      value: 500.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't6',
      title: 'Conta de China',
      value: 2.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),*/
  ];

  // Lista que retorna as transações recentes
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }


  // Função que adiciona uma transação
  _addTransaction(String title, double value, DateTime date) {
    // Cria uma nova transação
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    // Atualiza o estado
    setState(() {
      _transactions.add(newTransaction);
    });

    // Fecha o modal
    Navigator.of(context).pop();
  }


  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }


  // Função que abre o modal de adicionar transação
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  // widget que cria a tela
  @override
  Widget build(BuildContext context) {
    // retorna o Scaffold
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          // Botão de adicionar transação
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
          
        ],
      ),
      // Corpo da tela
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,// alinhamento
          children: [
            Chart(_recentTransactions),// gráfico
            TransactionList(_transactions, _deleteTransaction),// lista de transações
          ],
        ),
      ),
      // Botão de adicionar transação
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
