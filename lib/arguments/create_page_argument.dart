import 'package:everlast/model/event_model.dart';

class CreatePageArgument {
  final String documentId;
  final EventModel eventModel;
  final bool update;

  CreatePageArgument(
      {required this.documentId,
      required this.eventModel,
      required this.update});
}
