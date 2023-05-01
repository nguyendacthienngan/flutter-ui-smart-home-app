
import 'package:flutter_smart_home/src/domain/entities/quote_entity.dart';

class QuoteModel extends QuoteEntity {
  QuoteModel({
    required String quote,
    required String role,
    required String show
}): super(
    quote: quote,
    role: role,
    show: show
  );

  // Convert JSON to Dart objects
  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
      quote: json["quote"],
      role: json["role"],
      show: json["show"]
  );

  // Convert Dart objects to JSON
  @override
  Map<String, dynamic> toJson() => {
    "quote": quote,
    "role": role,
    "show": show
  };
}