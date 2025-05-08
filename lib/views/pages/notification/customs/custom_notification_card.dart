import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/notification_model.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/utils/format_time_stamp.dart';

class CustomNotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const CustomNotificationCard(this.notification, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(010),
      elevation: 5,
      shadowColor: ColorConstant.shadow,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              spacing: 15,
              children: [
                SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: notification.type.toLowerCase() == "purchase"
                            ? Image.asset("assets/icons/purchase.png")
                            : Image.asset(
                                "assets/icons/message_notification.png"))),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              notification.title,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled_rounded,
                            color: ColorConstant.gray,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Text(
                            FormatTimeStamp.formatToRelativeTime(
                                notification.time),
                            style: TextStyle(
                              color: ColorConstant.gray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
