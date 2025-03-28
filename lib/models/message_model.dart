import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/constants.dart';

class MessageModel {
  final String message;
  final Timestamp date;
  final String email;

  MessageModel(this.message, this.date, this.email);

  factory MessageModel.fromJson(Map jsonData) {
    return MessageModel(jsonData[kMessage], jsonData[kDate], jsonData['email']);
  }
}
