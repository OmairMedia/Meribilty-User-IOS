import 'package:flutter/material.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key? key}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

DateTime? dateTime;

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omni DateTime Picker',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  dateTime = await showOmniDateTimePicker(
                      context: context,
                      startFirstDate: DateTime.now(),
                      startInitialDate: DateTime.now());
                  print(dateTime);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Home()));
                },
                child: const Text("Show DateTime Picker"),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(dateTime);
                },
                child: const Text("Show DateTime Picker"),
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     List<DateTime>? dateTimeList =
              //         await showOmniDateTimeRangePicker(
              //       context: context,
              //       primaryColor: Colors.cyan,
              //       backgroundColor: Colors.grey[900],
              //       calendarTextColor: Colors.white,
              //       tabTextColor: Colors.white,
              //       unselectedTabBackgroundColor: Colors.grey[700],
              //       buttonTextColor: Colors.white,
              //       timeSpinnerTextStyle:
              //           const TextStyle(color: Colors.white70, fontSize: 18),
              //       timeSpinnerHighlightedTextStyle:
              //           const TextStyle(color: Colors.white, fontSize: 24),
              //       is24HourMode: false,
              //       isShowSeconds: false,
              //       startInitialDate: DateTime.now(),
              //       startFirstDate:
              //           DateTime(1600).subtract(const Duration(days: 3652)),
              //       startLastDate: DateTime.now().add(
              //         const Duration(days: 3652),
              //       ),
              //       endInitialDate: DateTime.now(),
              //       endFirstDate:
              //           DateTime(1600).subtract(const Duration(days: 3652)),
              //       endLastDate: DateTime.now().add(
              //         const Duration(days: 3652),
              //       ),
              //       borderRadius: const Radius.circular(16),
              //     );
              //   },
              //   child: const Text("Show DateTime Range Picker"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
