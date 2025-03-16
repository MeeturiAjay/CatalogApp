import 'package:flutter/material.dart';
import '../models/catalog.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      elevation: 0.0,
      child: ListTile(
        onTap: () {
          print("${item.name} pressed");
        },
        leading: Image.network(item.image),
        title: Text(
          item.name,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          item.desc,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Text(
          "\$${item.price}",
          textScaleFactor: 1.5,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
