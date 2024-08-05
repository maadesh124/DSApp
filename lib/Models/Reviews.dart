import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp4/Models/Model.dart';

class Review  extends Model{
  
  double currentRating;
  int totalRatings;
  String receiver;
  String receiverId;
  Map<String, Map<String, String>> reviews;

  Review({super.collectionType=Model.REVIEWS,
    this.receiver = '', // Default to an empty string
    this.receiverId = '', // Default to an empty string
    this.reviews = const {}, // Default to an empty map
    this.currentRating=0.0,
    this.totalRatings=0
  });

  @override
  void fromSnapShot(DocumentSnapshot snapshot) {
    setDocId(snapshot.id);
    Map<String, dynamic> map=snapshot.data()! as Map<String, dynamic> ;
      currentRating= map['currentRating'];
      totalRatings= map['totalRatings'];
      receiver= map['receiver'] as String? ?? '';
      receiverId= map['receiverId'] as String? ?? '';
      reviews= (map['reviews'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(
                key,
                (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)),
              ));
   
  }

  Map<String, dynamic> toMap() {
    return {
      'totalRatings':totalRatings,
      'currentRating':currentRating,
      'receiver': receiver,
      'receiverId': receiverId,
      'reviews': reviews.map((key, value) => MapEntry(
            key,
            value.map((k, v) => MapEntry(k, v)),
          )),
    };
  }
}
