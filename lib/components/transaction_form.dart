import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// classe que cria o formulário de transação
class TransactionForm extends StatefulWidget {
  // função que envia os dados do formulário
  final Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  // cria o estado do formulário
  State<TransactionForm> createState() => _TransactionFormState();
}

// estado do formulário
class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController(); // controlador do título

  final _valueController = TextEditingController(); // controlador do valor

  DateTime _selectedDate = DateTime.now(); // data selecionada

  // função que envia o formulário
  _submitForm() {
    final title = _titleController.text; // pega o texto do título
    final value = double.tryParse(_valueController.text) ??
        0.0; // pega o valor do controlador
    final date = _selectedDate; // pega a data selecionada

    // verifica se o título está vazio ou o valor é menor ou igual a 0
    if (title.isEmpty || value <= 0) {
      return; // retorna vazio
    }

    widget.onSubmit(title, value, date); // envia o formulário
  }

// função que exibe o seletor de data
  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // pega a data selecionada
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  // constrói o formulário
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          TextField(
            controller: _titleController,
            onSubmitted: (_) =>
                _submitForm(), // envia o formulário ao pressionar enter
            decoration: const InputDecoration(
              // decoração do campo de texto
              labelText: 'Título',
            ),
          ),
          TextField(
            controller: _valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) =>
                _submitForm(), // envia o formulário ao pressionar enter
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      DateFormat('d MMM y', 'pt-br')
                          .format(_selectedDate)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white54,
                      )),
                  TextButton(
                    child: const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    onPressed: () => _showDatePicker(),
                  ),
                  //
                ]),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.red.shade500,
              ),
            ),
            onPressed: _submitForm,
            child: Text(
              'Nova Transação',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ), // envia o formulário
          )
        ]),
      ),
    );
  }
}
