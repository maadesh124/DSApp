

class Ratings {
  String? receiver;
  String? receiverId;
  int numberOfRatings;
  double? currentRating;

  Ratings({
    this.receiver,
    this.receiverId,
    this.numberOfRatings=0,
    this.currentRating,
  });
}
