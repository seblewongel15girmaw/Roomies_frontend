import 'package:begara_mobile/feauters/chat/domain/entity/contacts.dart';

abstract class ContactsState{}

class Idle extends ContactsState{}

class LoadingContacts extends ContactsState{}

class LoadingContactsFailed extends ContactsState{}

class LoadingContactsSuceess extends ContactsState{
  final List<Contacts> contacts;
  final int userId;
  LoadingContactsSuceess({required this.contacts,required this.userId});
}