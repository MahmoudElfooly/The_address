import 'package:flutter/material.dart';

import '../../domain/entities/category_entituy.dart';

class CategoryChip extends StatelessWidget {
  final CategoryItemEntity category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 36, // Adjust the size
            backgroundImage: NetworkImage(category.image), // Network image
            // backgroundImage: AssetImage('assets/profile.png'), // Asset image
          ),
        ),
        SizedBox(
          width: 72,
          child: Center(
            child: Text(
              category.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
