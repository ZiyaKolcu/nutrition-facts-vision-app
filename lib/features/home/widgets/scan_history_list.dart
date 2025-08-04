import 'package:flutter/material.dart';
import 'scan_item_card.dart';

class ScanHistoryList extends StatelessWidget {
  const ScanHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ScanItemCard(title: 'Organic Almond Milk'),
        ScanItemCard(title: 'Vegan Protein Bar'),
        ScanItemCard(title: 'Gluten-free Bread'),
      ],
    );
  }
}
