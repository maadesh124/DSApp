class Review {
  final String receiver;
  final String receiverId;
  final Map<String, Map<String, String>> reviews;

  Review({
    this.receiver = '', // Default to an empty string
    this.receiverId = '', // Default to an empty string
    this.reviews = const {}, // Default to an empty map
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      receiver: map['receiver'] as String? ?? '',
      receiverId: map['receiverId'] as String? ?? '',
      reviews: (map['reviews'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(
                key,
                (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)),
              )),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiver': receiver,
      'receiverId': receiverId,
      'reviews': reviews.map((key, value) => MapEntry(
            key,
            value.map((k, v) => MapEntry(k, v)),
          )),
    };
  }
}
