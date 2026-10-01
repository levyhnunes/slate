/// Formats 1234567 as "1,234,567".
String groupThousands(int value) => value.toString().replaceAllMapped(
  RegExp(r'\B(?=(\d{3})+(?!\d))'),
  (_) => ',',
);

/// Formats 1050.5 as "$1,050.50".
String formatMoney(double value) {
  final cents = (value * 100).round();
  final fraction = cents.remainder(100).toString().padLeft(2, '0');
  return '\$${groupThousands(cents ~/ 100)}.$fraction';
}
