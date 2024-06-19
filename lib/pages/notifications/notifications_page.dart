import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 500),
        () => showCupertinoModalPopup(
            context: context,
            builder: (context) => const SimpleDialog(
                titlePadding: EdgeInsets.all(24),
                title: Center(
                  child: CustomText(
                    content: 'This page is under developing',
                    textOverflow: TextOverflow.visible,
                    color: Colors.black,
                  ),
                ))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Notifications> note = [
      Notifications('Your order has arrived', '2m'),
      Notifications('Your order is on its way', '50m'),
      Notifications('Your order has been placed', '1h'),
      Notifications('Confirm your phone number', '5d'),
      Notifications('We have updated our Privacy Policy', '6d'),
      Notifications('Your order has been cancelled', '1w'),
      Notifications('Welcome to Foodeck', '1w'),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: CustomText(
                    content: 'Notifications',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                controller: ScrollController(),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: note.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  note.indexOf(note.first) == index
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 12),
                                          child: Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          ),
                                        )
                                      : const SizedBox(),
                                  Text(note[index].notification)
                                ],
                              ),
                              CustomText(
                                  content: note[index].time, color: Colors.grey)
                            ])),
                    note.indexOf(note.first) == index
                        ? const LinearProgressIndicator(
                            color: AppColor.globalPink,
                          )
                        : const Divider()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Notifications {
  final String notification, time;

  Notifications(this.notification, this.time);
}
