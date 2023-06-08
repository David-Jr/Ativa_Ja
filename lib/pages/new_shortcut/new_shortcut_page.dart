import 'package:flutter/material.dart';

class NewShortcutPage extends StatefulWidget {
  const NewShortcutPage({super.key});

  @override
  State<NewShortcutPage> createState() => _NewShortcutPageState();
}

class _NewShortcutPageState extends State<NewShortcutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Novo Atalho"),
      ),
      body: Column(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Título"),
                hintText: "Exemplo: 5mt = 100mb, via Emola ",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              maxLines: 5,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Descrição"),
                hintText:
                    "Exemplo: Ativar megas de 5 meticais de duração de uma hora.",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
