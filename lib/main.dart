import 'package:flutter/material.dart';

void main() => runApp(const ListaDeCompras());

class ListaDeCompras extends StatelessWidget {
  const ListaDeCompras({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lista de Compras',
      home: ListaDeComprasPage(),
    );
  }
}

class ListaDeComprasPage extends StatefulWidget {
  const ListaDeComprasPage({Key? key}) : super(key: key);

  @override
  _ListaDeComprasPageState createState() => _ListaDeComprasPageState();
}

class _ListaDeComprasPageState extends State<ListaDeComprasPage> {
  final List<String> _compras = [];

  void _adicionarCompra(String compra) {
    setState(() {
      _compras.add(compra);
    });
  }

  void _removerCompra(String compra) {
    setState(() {
      _compras.remove(compra);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _compras.length,
              itemBuilder: (context, index) {
                final compra = _compras[index];
                return ListTile(
                  title: Text(compra),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removerCompra(compra),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Nova Compra',
              ),
              onSubmitted: (compra) {
                _adicionarCompra(compra);
              },
            ),
          ),
        ],
      ),
    );
  }
}
