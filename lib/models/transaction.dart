enum TransactionKind { transfer, topUp, conversion }

class Transaction {
  const Transaction(this.kind, this.time, this.amount);

  final TransactionKind kind;
  final String time;
  final double amount;

  String get title => switch (kind) {
    TransactionKind.transfer => 'Transfer',
    TransactionKind.topUp => 'Top up',
    TransactionKind.conversion => 'Conversion',
  };

  bool get isIncome => kind == TransactionKind.topUp;
}
