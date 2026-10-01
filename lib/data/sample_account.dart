import 'package:slate/models/transaction.dart';

/// Placeholder account data until there is a real backend.
const sampleUserName = 'DailyFlutterUI';
const sampleBalance = 22000;

const sampleTransactions = [
  Transaction(TransactionKind.transfer, '4:07pm', 1050),
  Transaction(TransactionKind.topUp, '12:07pm', 2400),
  Transaction(TransactionKind.conversion, '4:07pm', 950),
  Transaction(TransactionKind.transfer, '4:07pm', 1050),
  Transaction(TransactionKind.topUp, '9:15pm', 1200),
  Transaction(TransactionKind.conversion, '1:32pm', 470),
  Transaction(TransactionKind.transfer, '10:48am', 320),
];
