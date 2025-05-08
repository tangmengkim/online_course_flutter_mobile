import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/message_model.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/utils/format_time_stamp.dart';

class CustomMessageCard extends StatelessWidget {
  final MessageModel message;
  const CustomMessageCard(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: ColorConstant.shadow,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              spacing: 10,
              children: [
                SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: message.senderProfile != null ||
                                message.senderProfile!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: message.senderProfile ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                ),
                              )
                            : SizedBox())),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              message.sender,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            FormatTimeStamp.formatTimestamp(message.time),
                            style: TextStyle(
                              color: ColorConstant.darkGray,
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: ColorConstant.darkGray,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              message.body,
              style: TextStyle(color: ColorConstant.darkGray, fontSize: 14),
            ),
            message.imageUrl != null && message.imageUrl!.isNotEmpty
                ? RepaintBoundary(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        useOldImageOnUrlChange: true,
                        imageUrl: message.imageUrl ?? "",
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          );
                        },
                        progressIndicatorBuilder: (context, url, progress) {
                          return Center(
                              child: SizedBox(
                            width: 30, // Set the width of the indicator
                            height: 30, // Set the height of the indicator
                            child: CircularProgressIndicator(
                              value:
                                  progress.progress, // Use the progress value
                              strokeWidth: 3, // Adjust thickness
                            ),
                          ));
                        },
                        errorWidget: (context, url, error) => AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: ColorConstant.lightGray)),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
