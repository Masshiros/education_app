import 'package:education_app/core/global/media.dart';

enum ENotification {
  TEST(value: 'test', image: MediaRes.test),
  VIDEO(value: 'video', image: MediaRes.video),
  MATERIAL(value: 'material', image: MediaRes.material),
  COURSE(value: 'course', image: MediaRes.course),
  NONE(value: 'none', image: MediaRes.course);

  const ENotification({required this.value, required this.image});

  final String value;
  final String image;
}
