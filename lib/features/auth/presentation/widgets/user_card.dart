import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final void Function()? onSelect, onDelete;

  const UserCard({super.key, required this.name, this.onSelect, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          InkWell(
            onTap: onSelect,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 50,
                    ),
                    Text(
                      name,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
              padding: const EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }
}
