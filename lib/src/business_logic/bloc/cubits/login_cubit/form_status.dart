abstract class FormStatus {
  const FormStatus();
}

class FormStatusFailure extends FormStatus {
  final Exception exception;
  FormStatusFailure({required this.exception});
}

class FormStatusSuccess extends FormStatus {}

class FormStatusInitial extends FormStatus {
  const FormStatusInitial() : super();
}

class FormStatusSubmitting extends FormStatus {}