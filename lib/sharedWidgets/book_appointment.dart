import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Models/doctor.dart';
import 'package:medical_app/config/palette.dart';
import 'package:time_range/time_range.dart';

class BookAppointment extends StatefulWidget {
  final Doctor doctor;
  const BookAppointment({
    Key? key,
    required this.doctor
  }) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {

  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 00),
    const TimeOfDay(hour: 15, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100]!,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 70.0, left: 12.0, right: 12.0),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  margin: EdgeInsets.only(right: 12.0),
                  height: 70.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/profile.jpg",
                      ),
                    ),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.doctor.work!.title! + " " + widget.doctor.user!.fullname!}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.doctor.work!.field!}',
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Palette.textLight,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Palette.mainColor,
                            ),
                            child: Center(
                              child: Text(
                                "Selected",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.0,),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[100]!,
                          ),
                          child: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            size: 28.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: _buildDefaultSingleDatePickerWithValue(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Services",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Consultation",
                          style: TextStyle(
                              color: Palette.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Palette.textColor,
                          size: 28.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: _buildTimeRange(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Select visit time",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0
          ),
        ),
        const SizedBox(height: 20),
        TimeRange(
          fromTitle: const Text(
            'FROM',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0
            ),
          ),
          toTitle: const Text(
            'TO',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0
            ),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          activeTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          borderColor: Palette.textColor,
          activeBorderColor: Palette.mainColor,
          backgroundColor: Colors.transparent,
          activeBackgroundColor: Palette.mainColor,
          firstTime: const TimeOfDay(hour: 8, minute: 00),
          lastTime: const TimeOfDay(hour: 20, minute: 00),
          initialRange: _timeRange,
          timeStep: 30,
          timeBlock: 30,
          onRangeCompleted: (range) => setState(() => _timeRange = range),
          onFirstTimeSelected: (startHour) {},
        ),
      ],
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Palette.mainColor,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Palette.textColor,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Palette.mainColor,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          "Select Visit Day",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0
          ),
        ),
        SizedBox(height: 10.0,),
        CalendarDatePicker2(
          config: config,
          initialValue: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (values) =>
              setState(() => _singleDatePickerValueWithDefaultValue = values),
        ),
      ],
    );
  }

  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
