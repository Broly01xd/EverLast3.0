import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/arguments/card_page_arguments.dart';
import 'package:everlast/model/event_model.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:everlast/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../utils/api/notification_api.dart';
import '../utils/utils.dart';

class CreateEvent extends StatefulWidget {
  final CardPageArgument? argument;

  const CreateEvent({super.key, this.argument});
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late DateTime fromTime;
  late DateTime toTime;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  String? _pickedImagePath;
  File? image;
  NotificationApi notificationApi = NotificationApi();

  final nameController = TextEditingController();
  final eventController = TextEditingController();
  final addressController = TextEditingController();
  final locationController = TextEditingController();
  final datePickerController = TextEditingController();
  final fromTimeController = TextEditingController();
  final toTimeController = TextEditingController();
  void setReminder(int id, int minutesBefore) async {
    DateTime scheduledTime =
        DateTime.now().add(Duration(minutes: -minutesBefore));

    String title = 'Reminder Title';
    String body = 'Reminder Body';
    }

  String? _imagePath;
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImagePath = pickedImage.path;
        image = File(_pickedImagePath!);
      });
    }
  }

  MyTime? selectedReminderOption;

  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;
  void _selectFromTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _fromTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _fromTime = pickedTime;
      });
    }
  }

  void _selectToTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _toTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _toTime = pickedTime;
      });
    }
  }

  @override
  void initState() {
    // notificationApi.initialisationNotification();
    NotificationApi.init();
    if (widget.argument == null) {
      fromTime = DateTime.now();
      toTime = DateTime.now();
    } else {
      fromTime = widget.argument!.eventModel.fromTime.toDate();
      toTime = widget.argument!.eventModel.toTime.toDate();
      eventController.text = widget.argument!.eventModel.eventName;
      nameController.text = widget.argument!.eventModel.name;
      addressController.text = widget.argument!.eventModel.address;
      locationController.text = widget.argument!.eventModel.location;
    }
    super.initState();
  }
  // void setReminder() async {
  //   DateTime scheduleTime =
  //       DateTime.now().subtract(Duration(minutes: Duration.minutesPerHour));
  // }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ap.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : Column(
          children: [
            Container(
              height: 70,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(250),
                        bottomRight: Radius.circular(250),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 120,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        " Event Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.addRoute);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(8),
                        primary: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        const Text(
                          "Enter Event Details",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            height: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Event Name:"),
                          controller: eventController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                              return "Enter Event Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Name:"),
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                              return "Enter Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        buildDateTimePicker(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        DropdownButtonFormField<MyTime>(
                          value: selectedReminderOption,
                          onChanged: (MyTime? newValue) {
                            setState(() {
                              selectedReminderOption = newValue!;
                            });
                             

                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text('Reminder set for ${newValue?.label}'),
                            // ));
                          },
                          items: reminderOptions.map((MyTime option) {
                            return DropdownMenuItem<MyTime>(
                              value: option,
                              child: Text(option.label),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelText: 'Reminder',
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a reminder option';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Address:"),
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                              return "Enter Address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Location:"),
                          controller: locationController,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Row(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            if (_pickedImagePath != null) ...[
                              const SizedBox(height: 15, width: 69),
                              Image.file(
                                File(_pickedImagePath!),
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 2,
                              ),
                            ],
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _openImagePicker();
                            },
                            icon: const Icon(Icons.image),
                            label: const Text('Upload Image'),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            
                            onPressed: () {

                              if (selectedReminderOption == null) {
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Please Select Reminder Option'),
                            ));
                                
                                return;
                              }

                                final duration = Duration(
                                  minutes: selectedReminderOption!.type == 'minute' ? selectedReminderOption!.duration : 0,
                                  hours: selectedReminderOption!.type == 'hour' ? selectedReminderOption!.duration : 0,
                                  days: selectedReminderOption!.type == 'day' ? selectedReminderOption!.duration : 0
                                );

                                if (image == null) {
                                  showSnackBar(context, "Please select Event photo");
                                  return;
                                }

                                if (selectedReminderOption == null) {
                                  showSnackBar(context, "Please select remainder");
                                  return;
                                }

                                if (!fromTime.isAfter(DateTime.now())) {
                                  showSnackBar(context, "From time must be greater than current time");
                                  return;
                                }

                                if (!toTime.isAfter(fromTime)) {
                                  showSnackBar(context, "To time must greater than  from time");
                                  return;
                                }

                                if (!fromTime.subtract(duration).isAfter(DateTime.now())) {
                                  showSnackBar(context, "Select other remainder option");
                                  return;
                                }
                                
                              
                                 NotificationApi.showScheduledNotification(id: Random().nextInt(10000), scheduleTime: fromTime.subtract(duration
                                  ), title: 'Event Reminder', body: 'Personally arranged event notification');
                              //  NotificationApi.showScheduledNotification(scheduleTime: fromTime.subtract(Duration(minutes: 1)), title: 'Event Reminder', body: 'You have A Upcoming Event'); 
                                // NotificationApi.showScheduledNotification(scheduleTime: DateTime.now().add(Duration(minutes: 1)), title: 'Event Reminder', body: 'You have A Upcoming Event');
                              // NotificationApi.showNotification(id: 123, title: 'Testing', body: 'Test');
                              // notificationApi.sendNotification("Some Name",
                              //      "Your invitation has been created ");
                              // if (formKey.currentState!.validate()) {
                                // Validated successfully, continue with form submission\
                                
                                storeEventDataToFireStore();
                              // }
                            },
                            
                            child: const Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateTimePicker() => Column(
        children: [buildFrom(), buildTo()],
      );

  Widget buildFrom() => buildHeader(
        header: 'From',
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(fromTime),
                  onPressed: () => pickFromDateTime(pickDate: true),
                )),
            Expanded(
                child: buildDropDownField(
              text: Utils.toTime(fromTime),
              onPressed: () => pickFromDateTime(pickDate: false),
            )),
          ],
        ),
      );

  Future pickFromDateTime({
    required bool pickDate,
  }) async {
    final date = await pickDateTime(fromTime,
     pickDate: pickDate,firstDate: pickDate ? fromTime : null);
    if (date == null) return;

    if (date.isAfter(toTime)) {
      toTime =
          DateTime(date.year, date.month, date.day, toTime.hour, toTime.minute);
    }

    setState(() {
      fromTime = date;
    });
  }

  Future pickToDateTime({
    required bool pickDate,
  }) async {
    final date = await pickDateTime(toTime,
        pickDate: pickDate, firstDate: pickDate ? fromTime : null);
    if (date == null) return;

     if (date.isAfter(toTime)) {
      toTime =
          DateTime(date.year, date.month, date.day, toTime.hour, toTime.minute);
    }

    setState(() {
      toTime = date;
    });
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Widget buildTo() => buildHeader(
        header: 'To',
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(toTime),
                  onPressed: () => pickToDateTime(pickDate: true),
                )),
            Expanded(
                child: buildDropDownField(
              text: Utils.toTime(toTime),
              onPressed: () => pickToDateTime(pickDate: false),
            )),
          ],
        ),
      );

  Widget buildDropDownField(
          {required String text, required VoidCallback onPressed}) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onPressed,
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
          ),
          child
        ],
      );

  //store event data to firestore
  void storeEventDataToFireStore() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    EventModel eventModel = EventModel(
      createdAt: 'empty',
      id: '',
      eventPic: 'empty pic',
      eventName: eventController.text.trim(),
      location: locationController.text.trim(),
      name: nameController.text.trim(),
      fromTime: Timestamp.fromDate(fromTime),
      toTime: Timestamp.fromDate(toTime),
      address: addressController.text.trim(),
      joinedUser: [],
      duration: selectedReminderOption?.duration ?? 0, 
      durationType: selectedReminderOption?.type ?? '',
    );

    ap.saveEventDataToFirebase(
        context: context,
        documentId: widget.argument?.documentId,
        eventModel: eventModel,
        eventPic: image!,
        onSuccess: (documentId) {
          if (selectedReminderOption != null) {
            final date = fromTime.subtract(
              Duration(
                minutes: selectedReminderOption!.type == 'minute' 
                  ? selectedReminderOption!.duration 
                  : 0,
               hours: selectedReminderOption!.type == 'hour' 
                  ? selectedReminderOption!.duration 
                  : 0,
                days: selectedReminderOption!.type == 'day' 
                  ? selectedReminderOption!.duration 
                  : 0
              )
            );
          }
          showSnackBar(context, "Succesfully Created");

          Navigator.pushReplacementNamed(context, MyRoutes.cardRoute,
              arguments: documentId);
        },
      );
  }
}

List<String> reminderOptions1 = [
      '5 minutes before',
      '15 minutes before',
      '30 minutes before',
      '1 hour before',
      '2 hour before',
      '1 day before',
    ];

List<MyTime> reminderOptions = [
  MyTime(duration: 5, type: 'minute', label: '5 minutes before'),
  MyTime(duration: 15, type: 'minute', label: '15 minutes before'),
  MyTime(duration: 30, type: 'minute', label: '30 minutes before'),
  MyTime(duration: 1, type: 'hour', label: '1 hour before'),
  MyTime(duration: 2, type: 'hour', label: '2 hour before'),
  MyTime(duration: 1, type: 'day', label: '1 day before'),
];

class MyTime {
  final int duration;
  final String type;
  final String label;

  MyTime({ required this.duration, required this.type, required this.label });
}