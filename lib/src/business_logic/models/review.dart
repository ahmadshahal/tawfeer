class Review {
  int? id;
  late String ownerFullName;
  String? ownerImgUrl;
  late String comment;

  Review({
    this.id,
    this.ownerImgUrl,
    required this.comment,
    required this.ownerFullName,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    ownerFullName = json['ownerFullName'];
    ownerImgUrl = json['ownerImgUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'comment' : comment,
    };
  }
}
