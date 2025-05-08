import 'package:flutter_application_1/constraints/constraint.dart';
import 'package:flutter_application_1/controller/search_course_controller.dart';
import 'package:flutter_application_1/model/message_model.dart';
import 'package:flutter_application_1/model/notification_model.dart';

List<Suggestion> suggestion = [
  Suggestion(
      title: "What do you want to learn today?",
      icon: "assets/icons/ads_suggestion.png"),
  Suggestion(
      title: "What do you want to learn today?",
      icon: "assets/icons/ads_suggestion2.png")
];
List<LearningLevel> learnLevel = [
  LearningLevel(value: 40, maxValue: 45, title: "Packaging Design"),
  LearningLevel(value: 4, maxValue: 24, title: "Product Design"),
];

List<NotificationModel> sampleNotification = [
  NotificationModel(
    id: "1",
    title: "Successful Purchase!",
    body: "You have purchased the Flutter Development Course successfully.",
    sender: "Flutter Development Course",
    time: "2025-03-10T10:00:00Z",
    type: "Purchase",
  ),
  NotificationModel(
    id: "2",
    title: "Congratulations on completing the UX/UI Course.",
    body: "Congratulations on completing the UX/UI Course.",
    sender: "UX/UI Course",
    time: "2025-03-10T11:00:00Z",
    type: "Message",
  ),
  NotificationModel(
    id: "3",
    title: "Successful Purchase!",
    body: "You have purchased the Java Programming Course successfully.",
    sender: "Java Programming Course",
    time: "2025-03-10T12:30:00Z",
    type: "Purchase",
  ),
  NotificationModel(
    id: "4",
    title: "Congratulations on completing the Web Development Course.",
    body: "Great job on completing the Web Development Course!",
    sender: "Web Development Course",
    time: "2025-03-10T01:15:00Z",
    type: "Message",
  ),
  NotificationModel(
    id: "5",
    title: "Successful Purchase!",
    body: "You have purchased the Python Data Science Course successfully.",
    sender: "Python Data Science Course",
    time: "2025-03-10T02:45:00Z",
    type: "Purchase",
  ),
  NotificationModel(
    id: "6",
    title: "Congratulations on completing the Machine Learning Course.",
    body: "You have successfully completed the Machine Learning Course!",
    sender: "Machine Learning Course",
    time: "2025-03-10T03:20:00Z",
    type: "Message",
  ),
  NotificationModel(
    id: "7",
    title: "Successful Purchase!",
    body: "You have purchased the React Native Course successfully.",
    sender: "React Native Course",
    time: "2025-03-10T04:10:00Z",
    type: "Purchase",
  ),
  NotificationModel(
    id: "8",
    title: "Congratulations on completing the Cybersecurity Course.",
    body: "You have successfully completed the Cybersecurity Course.",
    sender: "Cybersecurity Course",
    time: "2025-03-10T05:00:00Z",
    type: "Message",
  ),
  NotificationModel(
    id: "9",
    title: "Successful Purchase!",
    body: "You have purchased the DevOps Course successfully.",
    sender: "DevOps Course",
    time: "2025-03-10T06:15:00Z",
    type: "Purchase",
  ),
  NotificationModel(
    id: "10",
    title: "Congratulations on completing the AI & Deep Learning Course.",
    body: "Great work on completing the AI & Deep Learning Course!",
    sender: "AI & Deep Learning Course",
    time: "2025-03-10T07:30:00Z",
    type: "Message",
  ),
];

List<MessageModel> sampleMessagesNotification = [
  MessageModel(
    id: "1",
    title: "Alice Johnson",
    body: "Great job on completing the Flutter Basics course!",
    sender: "Alice Johnson",
    time: "2025-03-10T10:00:00Z",
    senderProfile:
        "https://images.unsplash.com/photo-1492447273231-0f8fecec1e3a?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHJhbmRvbSUyMHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
    imageUrl:
        "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzI5fHxmbHV0dGVyJTIwY291cnNlfGVufDB8fDB8fHwy",
  ),
  MessageModel(
    id: "2",
    title: "Bert Pullman",
    body:
        "Congratulations on completing the first lesson, keep up the good work!",
    sender: "Bert Pullman",
    time: "2025-03-10T11:00:00Z",
    senderProfile:
        "https://images.unsplash.com/photo-1479936343636-73cdc5aae0c3?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHJhbmRvbSUyMHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
    imageUrl:
        "https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzI4fHxmbHV0dGVyJTIwY291cnNlfGVufDB8fDB8fHwy",
  ),
  MessageModel(
    id: "3",
    title: "Charlie Evans",
    body: "Your assignment has been reviewed, well done!",
    sender: "Charlie Evans",
    time: "2025-03-10T12:30:00Z",
    senderProfile:
        "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzV8fHJhbmRvbSUyMHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
    imageUrl: null,
  ),
  MessageModel(
    id: "4",
    title: "David Parker",
    body: "New materials have been added to your course, check them out!",
    sender: "David Parker",
    time: "2025-03-10T01:15:00Z",
    senderProfile:
        "https://images.unsplash.com/photo-1567186937675-a5131c8a89ea?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzl8fHJhbmRvbSUyMHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
    imageUrl:
        "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZWR1Y2F0aW9ufGVufDB8fDB8fHwy",
  ),
  MessageModel(
    id: "5",
    title: "Emma Wilson",
    body: "Reminder: Live Q&A session starts in an hour!",
    sender: "Emma Wilson",
    time: "2025-03-10T02:45:00Z",
    senderProfile:
        "https://plus.unsplash.com/premium_photo-1664461667785-975db0bb5e30?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8ODl8fHJhbmRvbSUyMHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
    imageUrl: null,
  ),
  MessageModel(
    id: "6",
    title: "Frank Mitchell",
    body: "You have unlocked a new badge for your progress!",
    sender: "Frank Mitchell",
    time: "2025-03-10T03:20:00Z",
    senderProfile:
        "https://images.unsplash.com/photo-1508179522353-11ba468c4a1c?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTEwfHxyYW5kb20lMjBwZXJzb258ZW58MHx8MHx8fDA%3D",
    imageUrl:
        "https://images.unsplash.com/photo-1594312915251-48db9280c8f1?q=80&w=4140&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ),
  MessageModel(
    id: "7",
    title: "Grace Hall",
    body: "Keep up the great work! You're making amazing progress.",
    sender: "Grace Hall",
    time: "2025-03-10T04:10:00Z",
    senderProfile:
        "https://plus.unsplash.com/premium_photo-1734348389942-a826bc4127cf?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTMzfHxyYW5kb20lMjBwZXJzb258ZW58MHx8MHx8fDA%3D",
    imageUrl: null,
  ),
  MessageModel(
    id: "8",
    title: "Henry Adams",
    body: "Check out the new study group for your course!",
    sender: "Henry Adams",
    time: "2025-03-10T05:00:00Z",
    senderProfile:
        "https://images.unsplash.com/photo-1501168296011-538e44c26981?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    imageUrl:
        "https://images.unsplash.com/photo-1543269865-cbf427effbad?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ),
  MessageModel(
    id: "9",
    title: "Isabella Clark",
    body: "Your feedback is valuable! Please rate your last session.",
    sender: "Isabella Clark",
    time: "2025-03-10T06:15:00Z",
    senderProfile:
        "https://images.unsplash.com/photo-1507537509458-b8312d35a233?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    imageUrl: null,
  ),
  MessageModel(
    id: "10",
    title: "James Turner",
    body: "A new challenge has been posted! Are you ready?",
    sender: "James Turner",
    time: "2025-03-10T07:30:00Z",
    senderProfile:
        "https://images.unsplash.com/photo-1514369118554-e20d93546b30?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    imageUrl:
        "https://images.unsplash.com/photo-1503676382389-4809596d5290?q=80&w=1476&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ),
];

final List<String> categoriesList = [
  "Design",
  "Painting",
  "Coding",
  "Visual identiy",
  "Mathmatics"
];
final List<RangeCourseDuration> courseDurationList = [
  RangeCourseDuration(3, 8),
  RangeCourseDuration(8, 14),
  RangeCourseDuration(14, 20),
  RangeCourseDuration(20, 24),
  RangeCourseDuration(24, 30),
];
