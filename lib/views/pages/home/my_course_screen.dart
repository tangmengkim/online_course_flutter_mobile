import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/home/customs/learned_card.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("My courses"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              AppSliverLearnedCard.learnedCard(
                  title: "Learned today", learnedTime: 46, courseTime: 60)
            ],
          ),
        ),
      ),
    );
  }
}
