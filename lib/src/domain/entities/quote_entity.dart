
class QuoteEntity {
  late final String quote;
  late final String role;
  late final String show;

  QuoteEntity({
    required this.quote,
    required this.role,
    required this.show
  });

  // Convert JSON to Dart objects
  factory QuoteEntity.fromJson(Map<String, dynamic> json) => QuoteEntity(
      quote: json["quote"],
      role: json["role"],
      show: json["show"]
  );

  // Convert Dart objects to JSON
  Map<String, dynamic> toJson() => {
    "quote": quote,
    "role": role,
    "show": show
  };

  static QuoteEntity empty() {
    return QuoteEntity(quote: "", role: "", show: "");
  }
}