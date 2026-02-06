class Package {
  final int id;
  final int diamonds;
  final int? bonus;
  final double price;
  final String? specialTag;

  const Package({
    required this.id,
    required this.diamonds,
    this.bonus,
    required this.price,
    this.specialTag,
  });

  int get totalDiamonds => diamonds + (bonus ?? 0);

  String get title {
    if (bonus != null && bonus! > 0) {
      return '$diamonds + $bonus Diamonds';
    }
    return '$diamonds Diamonds';
  }

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      diamonds: json['diamonds'],
      bonus: json['bonus'],
      price: (json['price'] as num).toDouble(),
      specialTag: json['specialTag'],
    );
  }
}
