// This file contains the Transaction class
class Transaction {// classe que cria uma transação
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({// construtor
    required this.id, 
    required this.title, 
    required this.value, 
    required this.date
    });
}