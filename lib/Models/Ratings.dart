class Ratings {
  final String receiver;
  final String receiverId;
  final int numberOfRatings;
  final double currentRating;

  Ratings({
    this.receiver = '', // Default to an empty string
    this.receiverId = '', // Default to an empty string
    this.numberOfRatings = 0,
    this.currentRating = 0.0, // Default to 0.0
  });

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      receiver: map['receiver'] as String? ?? '',
      receiverId: map['receiverId'] as String? ?? '',
      numberOfRatings: map['numberOfRatings'] as int? ?? 0,
      currentRating: (map['currentRating'] as double?) ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiver': receiver,
      'receiverId': receiverId,
      'numberOfRatings': numberOfRatings,
      'currentRating': currentRating,
    };
  }
}
