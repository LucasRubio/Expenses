import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

// classe que cria a lista de transações
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove; // lista de transações

  const TransactionList(this.transactions, this.onRemove,
      {super.key}); // construtor

  @override
  // constrói a lista de transações
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              // verifica se a lista de transações está vazia
              children: <Widget>[
                // se estiver vazia, exibe uma mensagem
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Nenhuma Transação Cadastrada!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              // se não estiver vazia, exibe a lista de transações
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                // cria um item da lista
                final tr = transactions[index]; // item da lista
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(6),
                  child: ListTile(
                    leading: CircleAvatar(
                      // avatar
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('R\$${tr.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      // título
                      tr.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      // subtítulo
                      DateFormat('d MMM y', 'pt-br').format(tr.date),
                    ),
                    trailing: IconButton(
                      // botão
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () {
                        onRemove(tr.id);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
