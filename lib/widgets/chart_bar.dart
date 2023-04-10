import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double ratio;
  const ChartBar({
    super.key,
    required this.label,
    required this.spending,
    required this.ratio,
  });
  String makeSpendingFit() {
    if (spending >= 1000000000) {
      return '${(spending / 1000000000).toStringAsFixed(1)}B';
    } else if (spending >= 1000000) {
      return '${(spending / 1000000).toStringAsFixed(1)}M';
    } else if (spending >= 1000) {
      return '${(spending / 1000).toStringAsFixed(1)}K';
    } else {
      return spending.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${makeSpendingFit()}'),
        SizedBox(
          height: 120,
          width: 20,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: ratio,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(label),
      ],
    );
  }
}
