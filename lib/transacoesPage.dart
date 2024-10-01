import 'package:flutter/material.dart';

class TransacoesPage extends StatefulWidget {
  @override
  _TransacoesPageState createState() => _TransacoesPageState();
}

class _TransacoesPageState extends State<TransacoesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _valorController = TextEditingController();
  final List<Map<String, dynamic>> _transacoes = [];

  // Função para adicionar uma nova transação
  void _adicionarTransacao(String tipo) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _transacoes.add({
          'tipo': tipo,
          'valor': double.parse(_valorController.text),
        });
        _valorController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de Transações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _valorController,
                    decoration:
                        InputDecoration(labelText: 'Valor da transação'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um valor';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um valor numérico';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => _adicionarTransacao('Depósito'),
                        child: Text('Adicionar Depósito'),
                      ),
                      ElevatedButton(
                        onPressed: () => _adicionarTransacao('Saque'),
                        child: Text('Adicionar Saque'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _transacoes.isEmpty
                  ? Center(child: Text('Nenhuma transação registrada'))
                  : ListView.builder(
                      itemCount: _transacoes.length,
                      itemBuilder: (context, index) {
                        final transacao = _transacoes[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(
                              transacao['tipo'] == 'Depósito'
                                  ? Icons.attach_money
                                  : Icons.money_off,
                              color: transacao['tipo'] == 'Depósito'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            title: Text(
                                '${transacao['tipo']} de R\$ ${transacao['valor']}'),
                            subtitle: Text('Transação ${index + 1}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
