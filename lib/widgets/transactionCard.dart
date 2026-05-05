import 'package:flutter/material.dart';
import 'package:wri_fluter/models/trxModel.dart';

class Transactioncard extends StatelessWidget {
  final TransactionModel? trx;
  const Transactioncard({super.key, this.trx});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: Key("bebas"),
      background: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        13,
                        185,
                        19,
                      ).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      color: const Color.fromARGB(255, 13, 185, 19),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trx?.title ?? "Title",
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        trx?.note ?? "catatan",
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        trx?.date.toString() ?? "20 September 2024",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                trx?.amount.toString() ?? "+15.000.000",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
