import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';

// classe que cria o gráfico
class Chart extends StatelessWidget {
  // lista de transações recentes
  final List<Transaction> recentTransaction;
  // construtor
  Chart(this.recentTransaction);


  // lista de transações agrupadas
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // gera uma lista de 7 elementos
      final weekDay = DateTime.now().subtract(
        // pega a data atual e subtrai
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        // percorre a lista de transações
        bool sameDay = recentTransaction[i].date.day == weekDay.day; // verifica se o dia é o mesmo

        bool sameMonth = recentTransaction[i].date.month == weekDay.month; // verifica se o mês é o mesmo

        bool sameYear = recentTransaction[i].date.year == weekDay.year; // verifica se o ano é o mesmo

        if (sameDay && sameMonth && sameYear) {
          // verifica se a data é a mesma
          totalSum += recentTransaction[i].value; // soma o valor da transação
        }
      }

      return {        
        'day': DateFormat.E('pt-br').format(weekDay)[0].toUpperCase(),
        'value': totalSum,
      }; // retorna o dia e o valor total
    }).reversed.toList(); // inverte a lista
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  // constrói o gráfico
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr['day'].toString(),
                  value: tr['value'] as double,
                  percentage: tr['value'] == 0
                      ? 0
                      : (tr['value'] as double) / _weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
