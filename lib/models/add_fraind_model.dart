class AddFraindModel {
  final String uid;
  final String displayName;
  final String? photoUrl;
  final String status;

  AddFraindModel({
    required this.uid,
    required this.displayName,
    this.photoUrl,
    this.status = 'offline',
  });

  factory AddFraindModel.fromMap(Map<String, dynamic> map) {
    return AddFraindModel(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? 'Unknown',
      photoUrl: map['photoUrl'],
      status: map['status'] ?? 'offline',
    );
  }
}
