import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: 'Test eventeee',
      description: 'example',
      location: 'Flutter app',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 40),
      ),
      androidParams: AndroidParams(
        emailInvites: ["ducnvph10517@fpt.edu.vn"],
      ),
      recurrence: recurrence,
    );
  }

  Event buildEvent1({
    Recurrence? recurrence,
    String? title,
    String? description,
    String? location,
    DateTime? start,
    DateTime? end,
    String? inviteperson,
  }) {
    return Event(
      title: title!,
      description: description!,
      location: location!,
      startDate: start!,
      endDate: end!,
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 40),
      ),
      androidParams: AndroidParams(
        emailInvites: [inviteperson!],
      ),
      recurrence: recurrence,
    );
  }

  TextEditingController titlectl = TextEditingController();
  TextEditingController desctrl = TextEditingController();
  TextEditingController locatrl = TextEditingController();
  TextEditingController invitectrl = TextEditingController();
  int? starthours, endhourse, startmin, endmin;
  DateTime dateTimeStart = DateTime.now();
  DateTime dateTimeEnd = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD CALENDER FLUTTER '),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Center(
              child: Text(
                'Thêm lịch',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {

                  titlectl.text = value;

              },
              controller: titlectl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  desctrl.text = value;
                });
              },
              controller: desctrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  locatrl.text = value;
                });
              },
              controller: locatrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Location',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  invitectrl.text = value;
                });
              },
              controller: invitectrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Invite person',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 10, minute: 47),
                      builder: (BuildContext context, Widget? child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                    ).then((value) {
                      setState(() {
                        starthours = value!.hour;
                        startmin = value.minute;
                      });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: Text((starthours != null && startmin != null)
                        ? '${starthours}:${startmin}'
                        : 'Chọn giờ bắt đầu'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 10, minute: 47),
                      builder: (BuildContext context, Widget? child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                    ).then((value) {
                      setState(() {
                        endhourse = value!.hour;
                        endmin = value.minute;
                      });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: Text((endhourse != null && endmin != null)
                        ? '${endhourse}:${endmin}'
                        : 'Chọn giờ kết thúc'),
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Ngày bắt đầu'),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        ).then((value) {
                          setState(() {
                            dateTimeStart = value!;
                          });
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child: Text(
                            '${DateFormat('yyyy-MM-dd').format(dateTimeStart)}'),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Ngày kết thúc'),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        ).then((value) {
                          dateTimeEnd = value!;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child: Text(
                            '${DateFormat('yyyy-MM-dd').format(dateTimeEnd)}'),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        )),
      ),
      // body: ListView(
      //   // mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ListTile(
      //       title: Text('Add normal event'),
      //       trailing: Icon(Icons.calendar_today),
      //       onTap: () {
      //         Add2Calendar.addEvent2Cal(
      //           buildEvent(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Add2Calendar.addEvent2Cal(buildEvent1(
              title: titlectl.text,
              location: locatrl.text,
              description: desctrl.text,
              start: DateTime(dateTimeStart.year, dateTimeStart.month,
                  dateTimeStart.day, starthours!, startmin!),
              end: DateTime(dateTimeEnd.year, dateTimeEnd.month,
                  dateTimeEnd.day, endhourse!, endmin!),
              inviteperson: invitectrl.text));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
