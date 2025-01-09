import 'package:flutter/material.dart'; // Flutter Material Design Widgets
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Screen utility for responsive design
import 'package:fluttertoast/fluttertoast.dart'; // Toast messages
import 'package:tasko/Services/API/insert_task.dart';
import 'package:tasko/UI/Screens/home/dashboard_screen.dart'; // Your custom dashboard screen
import 'package:tasko/UI/Themes/styles.dart'; // Your custom styles
import 'package:syncfusion_flutter_core/theme.dart'; // Syncfusion theming
import 'package:syncfusion_flutter_sliders/sliders.dart'; // Syncfusion sliders
import 'dart:ui'; // Standard Flutter UI package that includes TextDirection
import '../../../Themes/colors.dart'; // Your custom colors

class Filterpage extends StatefulWidget {
  const Filterpage({super.key});

  @override
  State<Filterpage> createState() => _FilterpageState();
}

class _FilterpageState extends State<Filterpage> {
  final TextEditingController _dateController = TextEditingController();
  late String formattedDate;
  late String formattedTime;
  List<String> images = [
    'assets/Dashboard/badminton-icon.png',
    'assets/Dashboard/skating-icon.png',
    'assets/Dashboard/football-icon.png',
    'assets/Dashboard/sports.png',
  ];
  List<String> sports = [
    'Skill',
    'Work',
    'Family',
    'Fitness',
  ];
  List Duration = ['⚡ ASAP', '⏳ Soon', '🌱 Whenever'];
  List _selectedfilter = [];
  String _selectedDate = "This week";
  String _selectedDuration = "One time";
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("sort icon pressed");
          // _togglePageVisibility();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: white100,
            enableDrag: true,
            useSafeArea: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  height: 700.h,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Image.asset(
                          'assets/Dashboard/filter.png',
                          width: 26.w,
                          height: 5.h,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 38.h, left: 59.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Let's Tackle Your Next Task! 🚀",
                                    style: filterstyle,
                                  ),
                                ],
                              ),
                            ),
                            // Task Name Heading
                            Padding(
                              padding: EdgeInsets.only(top: 16.h, left: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Task Name',
                                    style: filterstyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 8.h),
                              child: TextField(
                                controller:
                                    taskNameController, // Correctly initialized
                                style: filterstyle,
                                decoration: InputDecoration(
                                  hintText: 'Enter task name',
                                  hintStyle: filterstyle3,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: black200),
                                  ),
                                ),
                              ),
                            ),

                            // Task Description Heading
                            Padding(
                              padding: EdgeInsets.only(top: 16.h, left: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Task Description',
                                    style: filterstyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 8.h),
                              child: TextField(
                                controller: taskDescriptionController,
                                maxLines: 3,
                                style: filterstyle,
                                decoration: InputDecoration(
                                  hintText: 'Enter task description',
                                  hintStyle: filterstyle3,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: black200),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.h, left: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Category',
                                    style: filterstyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 9.w, top: 10.h),
                              child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    for (int i = 0; i < images.length; i++)
                                      Wrap(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 12.w, top: 10.h),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (_selectedfilter
                                                        .contains(sports[i])) {
                                                      setState(() {
                                                        _selectedfilter
                                                            .remove(sports[i]);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _selectedfilter
                                                            .add(sports[i]);
                                                      });
                                                    }
                                                    // print(_selectedfilter);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 38.r,
                                                    backgroundColor:
                                                        _selectedfilter
                                                                .contains(
                                                                    sports[i])
                                                            ? red1
                                                            : Colors
                                                                .grey.shade300,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      backgroundImage:
                                                          AssetImage(images[i]),
                                                      radius: 36.r,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  sports[i],
                                                  style: filterstyle2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, left: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date',
                                    style: filterstyle,
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.h, left: 16.w, right: 16.w),
                              child: TextField(
                                controller: _dateController,
                                cursorColor: Colors.grey,
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: 'dd/mm/yyyy',
                                    hintStyle: pStyle,
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        final DateTime? date =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2050),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData().copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: red,
                                                  surface: white100,
                                                  surfaceTint: white100,
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );

                                        if (date != null) {
                                          formattedDate =
                                              '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
                                          print(formattedDate);
                                        }

                                        setState(() {
                                          _dateController.text = formattedDate;
                                        });
                                      },
                                      icon: const Icon(Icons.calendar_month),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, left: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Time',
                                    style: filterstyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.h, left: 16.w, right: 16.w),
                              child: TextField(
                                controller: _timeController,
                                cursorColor: Colors.grey,
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: 'hh:mm',
                                  hintStyle: pStyle,
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      final TimeOfDay? timeOfDay =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: selectedTime,
                                        initialEntryMode:
                                            TimePickerEntryMode.dial,
                                      );

                                      if (timeOfDay != null) {
                                        formattedTime =
                                            '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
                                        print(formattedTime);
                                      }

                                      setState(() {
                                        _timeController.text = formattedTime;
                                      });
                                    },
                                    icon: const Icon(Icons.access_time),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, left: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Task Priority',
                                    style: filterstyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: SizedBox(
                                height: 80.93.h,
                                child: ListView.builder(
                                    itemCount: Duration.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.h, vertical: 10.h),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedDuration =
                                                  Duration[index];
                                            });
                                          },
                                          child: Chip(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize.padded,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              side: BorderSide(
                                                  color: _selectedDuration ==
                                                          Duration[index]
                                                      ? red1
                                                      : black100),
                                              label: SizedBox(
                                                height: 28.92.h,
                                                child: Center(
                                                  child: Text(
                                                    Duration[index],
                                                    style: filterstyle3,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      );
                                    }),
                              ),
                            ),

                            ElevatedButton(
                              style: ButtonStyle(
                                  elevation: const WidgetStatePropertyAll(0),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.r))),
                                  backgroundColor:
                                      const WidgetStatePropertyAll(red1),
                                  fixedSize: WidgetStatePropertyAll(
                                      Size(360.43.w, 53.74.h))),
                              onPressed: () async {
                                print(
                                    "------------DATA COLLECTED----------------");
                                print(taskDescriptionController.text);
                                print(taskNameController.text);
                                print(formattedDate);
                                // print(sports);
                                print(formattedTime);
                                print(_selectedDuration);
                                print(_selectedfilter);
                                List<String> dateParts =
                                    formattedDate.split('-');
                                int day = int.parse(dateParts[0]);
                                int month = int.parse(dateParts[1]);
                                int year = int.parse(dateParts[2]);
                                await insertTask(
                                  taskName: taskNameController.text,
                                  taskDesc: taskDescriptionController.text,
                                  taskDate: DateTime(
                                      year, month, day), // Example date
                                  taskTime: formattedTime, // Example time
                                  taskComp: false, // Task incomplete
                                  taskType: _selectedfilter[0], // Task type
                                );

                                Fluttertoast.showToast(
                                    msg: "New Task Created Successfully!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: red1,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                List<String> interests =
                                    _selectedfilter.cast<String>();
                                if (interests.isEmpty) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(
                                          interestList: [
                                            'Cricket',
                                            'Football',
                                            'Skating',
                                            'Fitness'
                                          ]),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Dashboard(interestList: interests),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'APPLY',
                                style: filterstyle5,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
        child: Container(
          width: 500, // Adjust width as per your design
          height: 80, // Adjust height as per your design
          decoration: BoxDecoration(
            color: red1, // Blue background color
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Task",
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontSize: 18, // Adjust font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Create new task here.",
                      style: TextStyle(
                        color:
                            Colors.white.withOpacity(0.8), // Lighter text color
                        fontSize: 12, // Adjust font size
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white, // White background for the icon
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.blue, // Blue color for the "+" icon
                    size: 24, // Adjust icon size
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _SfThumbShape extends SfThumbShape {
  final IconData icon1;
  final IconData icon2;

  _SfThumbShape(this.icon1, this.icon2);

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    const double outerSquareSize = 32.0;
    const double innerSquareSize = 29.0; // adjust this value as needed
    const double borderRadius = 10.0; // adjust this value as needed

    // Draw outer square
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center,
          width: outerSquareSize,
          height: outerSquareSize,
        ),
        const Radius.circular(borderRadius),
      ),
      Paint()
        ..color = themeData.activeTrackColor!
        ..style = PaintingStyle.fill
        ..strokeWidth = 0.5,
    );

    // Draw inner square
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center,
          width: innerSquareSize,
          height: innerSquareSize,
        ),
        const Radius.circular(borderRadius),
      ),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill
        ..strokeWidth = 0.5,
    );

    // Draw first icon inside inner square
    // Draw first icon inside inner square
    // Draw first icon inside inner square
    // Draw first icon inside inner square
    final TextPainter textPainter1 = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon1.codePoint),
        style: TextStyle(
          fontSize: 24.0, // further reduced font size
          fontFamily: icon1.fontFamily,
          color: darkgrey, // adjust this value as needed
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter1.layout();
    textPainter1.paint(
      context.canvas,
      center +
          Offset(innerSquareSize / 50 - textPainter1.width / 3,
              -textPainter1.height / 2),
    );

// Draw second icon inside inner square
    final TextPainter textPainter2 = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon2.codePoint),
        style: TextStyle(
          fontSize: 24.0, // further reduced font size
          fontFamily: icon2.fontFamily,
          color: darkgrey, // adjust this value as needed
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter2.layout();
    textPainter2.paint(
      context.canvas,
      center +
          Offset(
              innerSquareSize / 50 +
                  textPainter1.width / 3 -
                  textPainter2.width,
              -textPainter2.height / 2),
    );
  }
}
