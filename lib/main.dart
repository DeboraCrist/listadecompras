import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(
        title: '',
      ),
    );
  }
}

final listaDeComprasProvider =
    StateNotifierProvider<ListaDeComprasNotifier, List<String>>((ref) {
  return ListaDeComprasNotifier();
});

class ListaDeComprasNotifier extends StateNotifier<List<String>> {
  ListaDeComprasNotifier() : super([]);

  void adicionarItem(String item) {
    state = [...state, item];
  }

  void removerItem(String item) {
    state = [...state.where((element) => element != item)];
  }

  void atualizarItem(String item, String novoItem) {
    final novaLista = <String>[];
    for (var i = 0; i < state.length; i++) {
      if (state[i] == item) {
        novaLista.add(novoItem);
      } else {
        novaLista.add(state[i]);
      }
    }
    state = novaLista;
  }
}

class ListaDeVendasNotifier extends StateNotifier<List<String>> {
  ListaDeVendasNotifier() : super([]);

  void adicionarItem(String item) {
    state = [...state, item];
  }

  void removerItem(String item) {
    state = [...state.where((element) => element != item)];
  }

  void atualizarItem(String item, String novoItem) {
    final novaLista = <String>[];
    for (var i = 0; i < state.length; i++) {
      if (state[i] == item) {
        novaLista.add(novoItem);
      } else {
        novaLista.add(state[i]);
      }
    }
    state = novaLista;
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaDeCompras = ref.watch(listaDeComprasProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listaDeCompras.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(listaDeCompras[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref
                                .read(listaDeComprasProvider.notifier)
                                .removerItem(listaDeCompras[index]);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final novoItem = await showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Editar item'),
                                  content: TextField(
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        labelText: 'Novo nome do item'),
                                    onSubmitted: (String value) {
                                      Navigator.of(context).pop(value);
                                    },
                                  ),
                                );
                              },
                            );
                            if (novoItem != null) {
                              ref
                                  .read(listaDeComprasProvider.notifier)
                                  .atualizarItem(
                                      listaDeCompras[index], novoItem);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (String value) {
                  ref
                      .read(listaDeComprasProvider.notifier)
                      .adicionarItem(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Adicionar item',
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'compras',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall),
            label: 'vendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'balanço',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(
                  title: 'Compras',
                ),
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(
                  title: 'Vendas',
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
