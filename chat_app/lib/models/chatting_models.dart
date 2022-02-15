class ChattingModel {
  ChattingModel(this.pk, this.name, this.text, this.upTime, this.state);
  final String pk;
  final String name;
  final String text;
  final int upTime;
  final bool state;
  factory ChattingModel.fromJson(Map<String, dynamic> json) {
    return ChattingModel(
        json['pk'], json['name'], json['text'], json['upTime'], json['state']);
  }

  Map<String, dynamic> toJson() {
    return {
      'pk': pk,
      'name': name,
      'text': text,
      'upTime': upTime,
      'state': state,
    };
  }

  // factory ChattingModel.fromMap(Map<String, dynamic> map) {
  //   return ChattingModel(
  //     map['pk'] ?? '',
  //     map['name'] ?? '',
  //     map['text'] ?? '',
  //     map['upTime']?.toInt() ?? 0,
  //   );
  // }

  // String toJson() => json.encode(toMap());
}
