import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // List of past events (replace this with your own data source)
    List<Event> pastEvents = [
      Event(
        name: "Birthday Party for John",
        date: DateTime(2023, 5, 28),
        location: "John's Residence",
        description:
            "A surprise birthday party for John with friends and family.",
      ),
      Event(
        name: "Company Team Building",
        date: DateTime(2023, 5, 26),
        location: "Adventure Park",
        description:
            "A day filled with team-building activities and bonding exercises for all employees.",
      ),
      // Add more past events here
    ];

    // Filter past events from the current date
    List<Event> filteredEvents =
        pastEvents.where((event) => event.date.isBefore(currentDate)).toList();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Event History"),
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 1),
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.deepPurple,
          Colors.purple,
          Colors.purpleAccent
        ])),
        child: ListView.builder(
          itemCount: filteredEvents.length,
          itemBuilder: (BuildContext context, int index) {
            Event event = filteredEvents[index];
            return ListTile(
              title: Text(event.name,style: TextStyle(color:Colors.white)),
              subtitle: Text("Date: ${event.date.toString().substring(0, 10)}",style: TextStyle(color:Colors.white)),
              onTap: () {
                // Handle tapping on a past event, e.g., navigate to event details screen
                // You can add your own implementation here
              },
            );
          },
        ),
      ),
    );
  }
}

class Event {
  final String name;
  final DateTime date;
  final String location;
  final String description;

  Event({
    required this.name,
    required this.date,
    required this.location,
    required this.description,
  });
}
