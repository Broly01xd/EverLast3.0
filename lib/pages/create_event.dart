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
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }
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
  // Rest of the code...



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
                    top: 15,
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
                  Positioned(
                    left: 10,
                    top: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,"/add"); 
                      },
                      child: Icon(
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
  onTap: _selectFromTime,
  child: AbsorbPointer(
    child: TextFormField(
      decoration: InputDecoration(
        labelText: "From Time:",
        suffixIcon: Icon(Icons.access_time),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter From Time";
        } else {
          return null;
        }
      },
      readOnly: true,
      controller: TextEditingController(
        text: _fromTime != null
            ? _fromTime!.format(context)
            : "",
      ),
    ),
  ),
),
SizedBox(height: MediaQuery.of(context).size.height * 0.05),
GestureDetector(
  onTap: _selectToTime,
  child: AbsorbPointer(
    child: TextFormField(
      decoration: InputDecoration(
        labelText: "To Time:",
        suffixIcon: Icon(Icons.access_time),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter To Time";
        } else {
          return null;
        }
      },
      readOnly: true,
      controller: TextEditingController(
        text: _toTime != null
            ? _toTime!.format(context)
            : "",
      ),
    ),
  ),
),          
SizedBox(height: MediaQuery.of(context).size.height * 0.05),
TextFormField(
decoration: InputDecoration(labelText: "Address:"),
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
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                                Navigator.pushNamed(context, "/Uploadinvi");
                                // Add button onPressed logic here
                                print('Add button pressed');
                              },
                            icon: Icon(Icons.image),
                            label: Text('Upload Image'),
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
}


