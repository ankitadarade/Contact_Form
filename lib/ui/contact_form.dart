import 'package:flutter/material.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/contact_cubit.dart'; 

class ContactFormPage extends StatelessWidget {
  const ContactFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            ContactFormCubit(), // Create an instance of ContactFormCubit
        child: ContactForm(),
      ),
    );
  }
}

class ContactForm extends StatelessWidget {
  // Define form controllers and focus nodes
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactFormCubit, ContactFormState>(
      listener: (context, state) {
        if (state is ContactFormSubmissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form submitted successfully')),
          );

          // Clear form fields after successful submission
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _addressController.clear();
        } else if (state is ContactFormSubmissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form submission failed: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextFormFieldWrapper is a custom widget for styling
                TextFormFieldWrapper(
                  borderFocusedColor: Colors.amber,
                  formField: TextFormField(
                    focusNode: _nameFocus,
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: 'Name', border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldWrapper(
                  borderFocusedColor: Colors.amber,
                  formField: TextFormField(
                      focusNode: _phoneFocus,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                          labelText: 'Phone', border: InputBorder.none),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Phone number';
                        }
                        try {
                          int.parse(value);
                        } catch (e) {
                          return 'Please enter a valid integer';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number),
                  position: TextFormFieldPosition.alone,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldWrapper(
                  borderFocusedColor: Colors.amber,
                  formField: TextFormField(
                    focusNode: _emailFocus,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email', border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldWrapper(
                  borderFocusedColor: Colors.amber,
                  formField: TextFormField(
                    focusNode: _addressFocus,
                    controller: _addressController,
                    decoration: const InputDecoration(
                        labelText: 'Address', border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90, top: 30),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final name = _nameController.text;
                            final phone = int.parse(_phoneController.text);
                            final email = _emailController.text;
                            final address = _addressController.text;
                            context.read<ContactFormCubit>().submitForm(
                                  name: name,
                                  phone: phone,
                                  email: email,
                                  address: address,
                                );

                            // Unfocus all focus nodes to hide the keyboard
                            _nameFocus.unfocus();
                            _emailFocus.unfocus();
                            _phoneFocus.unfocus();
                            _addressFocus.unfocus();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(width: 12.0),
                      ElevatedButton(
                        onPressed: () {
                         
                          _nameController.clear();
                          _phoneController.clear();
                          _emailController.clear();
                          _addressController.clear();

                          _nameFocus.unfocus();
                          _emailFocus.unfocus();
                          _phoneFocus.unfocus();
                          _addressFocus.unfocus();
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
