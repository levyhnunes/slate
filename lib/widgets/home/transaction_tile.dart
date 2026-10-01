import 'package:flutter/material.dart';

import 'package:slate/models/transaction.dart';
import 'package:slate/theme/app_theme.dart';
import 'package:slate/utils/formatters.dart';
import 'package:slate/widgets/home/transaction_icon.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    required this.showDivider,
  });

  final Transaction transaction;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final amount = formatMoney(transaction.amount);

    return Container(
      height: 73,
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.hairline))
            : null,
      ),
      child: Row(
        children: [
          TransactionIcon(kind: transaction.kind),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.time,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            transaction.isIncome ? '+$amount' : amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
              color: transaction.isIncome ? AppColors.positive : null,
            ),
          ),
        ],
      ),
    );
  }
}
