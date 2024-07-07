
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/group.entities.dart';

class GroupModel extends Group {
  const GroupModel({
    required super.id,
    required super.name,
    required super.members,
    required super.courseId,
    super.lastMessage,
    super.lastMessageSenderName,
    super.lastMessageTimestamp,
    super.groupImageUrl,
  });

  GroupModel.empty()
      : this(
          id: '',
          name: '',
          members: const [],
          lastMessage: '',
          courseId: '',
          groupImageUrl: '',
          lastMessageSenderName: '',
          lastMessageTimestamp: DateTime.now(),
        );

  GroupModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          courseId: map['courseId'] as String,
          members: List<String>.from(map['members'] as List<dynamic>),
          // OR
          // members: (map['members'] as List<dynamic>).cast<String>(),
          // OR
          // members: (map['members'] as List<dynamic>).map((e) => e as String)
          // .toList(),
          lastMessage: map['lastMessage'] as String?,
          lastMessageSenderName: map['lastMessageSenderName'] as String?,
          lastMessageTimestamp:
              (map['lastMessageTimestamp'] as Timestamp?)?.toDate(),
          groupImageUrl: map['groupImageUrl'] as String?,
        );

  GroupModel copyWith({
    String? id,
    String? name,
    String? courseId,
    List<String>? members,
    DateTime? lastMessageTimestamp,
    String? lastMessageSenderName,
    String? lastMessage,
    String? groupImageUrl,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      courseId: courseId ?? this.courseId,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderName:
          lastMessageSenderName ?? this.lastMessageSenderName,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'name': name,
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageSenderName': lastMessageSenderName,
      'lastMessageTimestamp':
          lastMessage == null ? null : FieldValue.serverTimestamp(),
      'groupImageUrl': groupImageUrl,
    };
  }
}