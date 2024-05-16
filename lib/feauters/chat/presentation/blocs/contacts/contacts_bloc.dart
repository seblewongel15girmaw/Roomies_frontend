import 'dart:async';

import 'package:begara_mobile/feauters/auth/data/utils/functions.dart';
import 'package:begara_mobile/feauters/chat/domain/usecase/get_contacts.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/contacts/contacts_event.dart';
import 'package:begara_mobile/feauters/chat/presentation/blocs/contacts/contacts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  GetContacts getContacts;
  ContactsBloc(this.getContacts) : super(Idle()) {
    on<ContactsEvent>(_loadContacts);
  }

  FutureOr<void> _loadContacts(ContactsEvent event, Emitter emit) async {
    emit(LoadingContacts());
    final userId = await getUserId();
    Params param = Params(userId: userId);
    final response = await getContacts(param);
    response.fold((l) {
      print("we failed you guys");
      emit(LoadingContactsFailed());
    }, (contacts) {
      emit(LoadingContactsSuceess(contacts: contacts,userId: userId));
    });
  }
}
