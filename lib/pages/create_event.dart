import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateEvent extends StatefulWidget {
@override
_CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
final formKey = GlobalKey<FormState>();
String? _imagePath;
DateTime? _selectedDate; // Added variable to store selected date
TimeOfDay? _selectedTime; // Added variable to store selected time

Future<void> _pickImageFromGallery() async {
final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
if (pickedImage != null) {
setState(() {
_imagePath = pickedImage.path;
});
}
}

Future<void> _selectTime() async {
final TimeOfDay? pickedTime = await showTimePicker(
context: context,
initialTime: TimeOfDay.now(),
);
if (pickedTime != null) {
setState(() {
_selectedTime = pickedTime;
});
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: SafeArea(
child: Column(
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
top: 20,
right: 120,
child: Container(
padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
SizedBox(height: MediaQuery.of(context).size.height * 0.04),
const Text(
"Enter Event Details",
style: TextStyle(
color: Colors.black,
fontSize: 20,
height: 1,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: MediaQuery.of(context).size.height * 0.05),
TextFormField(
decoration: InputDecoration(labelText: "Event Name:"),
validator: (value) {
if (value!.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
return "Enter Full Name";
} else {
return null;
}
},
),
SizedBox(height: MediaQuery.of(context).size.height * 0.05),
TextFormField(
decoration: InputDecoration(labelText: "Name:"),
validator: (value) {
if (value!.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
return "Enter Full Name";
} else {
return null;
}
},
),
SizedBox(height: MediaQuery.of(context).size.height * 0.05),
TextFormField(
decoration: InputDecoration(labelText: "Date:"),
validator: (value) {
if (value!.isEmpty || !RegExp(r'^[+][(]{0,1}[0-9]{1,4}[)]{0,1}[-\s./0-9]+$').hasMatch(value)) {
return "Enter Date";
} else {
return null;
}
},
onTap: () async {
DateTime? selectedDate = await showDatePicker(
context: context,
initialDate: DateTime.now(),
firstDate: DateTime(2022),
lastDate: DateTime(2025),
);
if (selectedDate != null) {
setState(() {
_selectedDate = selectedDate;
});
}
},
readOnly: true, // Make the field read-only
controller: TextEditingController(
text: _selectedDate != null
? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
: "",
),
),
SizedBox(height: MediaQuery.of(context).size.height * 0.05),
GestureDetector(
onTap: _selectTime, // Call the method to select time
child: AbsorbPointer(
child: TextFormField(
decoration: InputDecoration(
labelText: "Time:",
suffixIcon: Icon(Icons.access_time),
),
validator: (value) {
if (value!.isEmpty) {
return "Enter Time";
} else {
return null;
}
},
readOnly: true, // Make the field read-only
controller: TextEditingController(
text: _selectedTime != null
? "${_selectedTime!.format(context)}"
: "",
),
),
),
),
SizedBox(height: MediaQuery.of(context).size.height * 0.05),
TextFormField(
decoration: InputDecoration(labelText: "Location:"),
validator: (value) {
if (value!.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
return "Enter Location";
} else {
return null;
}
},
),
SizedBox(height: MediaQuery.of(context).size.height * 0.05),
TextFormField(
decoration: InputDecoration(labelText: "Contact:"),
validator: (value) {
if (value!.isEmpty || !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s./0-9]+$').hasMatch(value)) {
return "Enter Contact";
} else {
return null;
}
},
),

SizedBox(height: MediaQuery.of(context).size.height * 0.05),
Text(
"Select Image:",
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.normal,
),
),

SizedBox(height: MediaQuery.of(context).size.height * 0.05),
GestureDetector(
onTap: _pickImageFromGallery, // Call the method to pick an image from the gallery
child: Row(
children: [
Icon(Icons.add_a_photo),
SizedBox(width: 10),
Container(
width: 100,
height: 100,
decoration: BoxDecoration(
border: Border.all(color: Colors.black),
borderRadius: BorderRadius.circular(15),
),
child: _imagePath != null
? Image.file(File(_imagePath!), fit: BoxFit.cover)
: null,
),
],
),
),
],
),
),
),
),
),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Expanded(child: Container()),
Container(
height: 50,
child: ElevatedButton(
onPressed: () {
Navigator.pushNamed(context, "/card");
if (formKey.currentState!.validate()) {
final SnackBar snackBar = SnackBar(content: Text('Creating Invitation'));
ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
},
style: ElevatedButton.styleFrom(
shape: CircleBorder(),
padding: EdgeInsets.all(12),
// primary: Colors.purple,
elevation: 4,
shadowColor: Colors.black.withOpacity(0.2),
),
child: Icon(Icons.arrow_forward),

),
),
],
),
],
),
),
);
}
}