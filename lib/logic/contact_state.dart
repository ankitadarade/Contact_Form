part of 'contact_cubit.dart';


// Contact Form States

abstract class ContactFormState {}

class ContactFormInitial extends ContactFormState {}

class ContactFormSubmitting extends ContactFormState {}

class ContactFormSubmissionSuccess extends ContactFormState {}

class ContactFormSubmissionFailure extends ContactFormState {
  final String error;

  ContactFormSubmissionFailure({required this.error});
}

