
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'contact_state.dart';


class ContactFormCubit extends Cubit<ContactFormState> {
  ContactFormCubit() : super(ContactFormInitial());

  void submitForm({required String name, required int phone,required String email, required String address}) async {
    emit(ContactFormSubmitting());

    try {
      
      await Future.delayed(const Duration(seconds: 1));
  
      final collection = FirebaseFirestore.instance.collection('Contacts');

      await collection.add({
        'name': name,
        'phone':phone,
        'email': email,
        'address': address,
       
      });

      emit(ContactFormSubmissionSuccess());
    } catch (e) {
      emit(ContactFormSubmissionFailure(error: e.toString()));
    }
  }
}
