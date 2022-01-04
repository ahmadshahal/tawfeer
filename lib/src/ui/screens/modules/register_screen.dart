import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/obscure_text_cubit/obscure_text_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/register_cubit/register_cubit.dart';
import 'package:tawfeer/src/business_logic/utils/validation_utility.dart';
import 'package:tawfeer/src/ui/components/loading_dialog.dart';
import 'package:tawfeer/src/ui/components/my_material_button.dart';
import 'package:tawfeer/src/ui/components/my_text_form_field.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: ScrollConfiguration(
              behavior: NonGlowScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Create an account',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 60.0),
                    BlocListener<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSubmitting) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return const LoadingDialog();
                            },
                          );
                        } else if (state is RegisterSuccess) {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/home');
                        } else if (state is RegisterFailure) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text((state.exception.message + '.'))));
                        }
                      },
                      child: _form(context),
                    ),
                    const SizedBox(height: 5.0),
                    _loginRow(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _fullNameTextFormField(context),
          const SizedBox(height: 15.0),
          _emailTextFormField(context),
          const SizedBox(height: 15.0),
          BlocProvider(
            create: (context) => ObscureTextCubit(),
            child: _passwordTextFormField(context),
          ),
          const SizedBox(height: 15.0),
          _phoneNumberTextFormField(context),
          const SizedBox(height: 25.0),
          _materialButton(context),
        ],
      ),
    );
  }

  Widget _fullNameTextFormField(BuildContext context) {
    return MyTextFormField(
      label: 'Full Name',
      textInputType: TextInputType.text,
      textController: _fullNameController,
      validate: (String? value) {
        return ValidationUtility.validateRegisterFullName(value ?? "");
      },
    );
  }

  Widget _emailTextFormField(BuildContext context) {
    return MyTextFormField(
      label: 'Email',
      textInputType: TextInputType.emailAddress,
      textController: _emailController,
      validate: (String? value) {
        return ValidationUtility.validateEmail(value ?? "");
      },
    );
  }

  Widget _passwordTextFormField(BuildContext context) {
    return BlocBuilder<ObscureTextCubit, ObscureTextState>(
      builder: (context, state) {
        return MyTextFormField(
          validate: (String? value) {
            return ValidationUtility.validateRegisterPassword(value ?? "");
          },
          obscureText: state.obscureText,
          label: 'Password',
          textInputType: TextInputType.visiblePassword,
          textController: _passwordController,
          suffixIconButton: IconButton(
            icon: Icon(
              state.obscureText
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color: MyColors.darkGrey,
            ),
            onPressed: () {
              BlocProvider.of<ObscureTextCubit>(context)
                  .changeObscureValue(value: !state.obscureText);
            },
            iconSize: 16.0,
            splashRadius: 0.1, // Change this
          ),
        );
      },
    );
  }

  Widget _phoneNumberTextFormField(BuildContext context) {
    return MyTextFormField(
      label: 'Phone Number',
      hint: '934256783',
      prefixText: '+963',
      maxLength: 9,
      textInputType: TextInputType.phone,
      textController: _phoneNumberController,
      validate: (String? value) {
        return ValidationUtility.validateRegisterPhoneNumber(value ?? "");
      },
    );
  }

  Widget _materialButton(BuildContext context) {
    return MyMaterialButton(
      text: 'Register',
      callBack: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<RegisterCubit>(context).submit(
            fullName: _fullNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            phoneNumber: _phoneNumberController.text,
          );
        }
      },
    );
  }

  Widget _loginRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(
            fontSize: 14.0,
            color: MyColors.darkGrey,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 13.0,
              color: MyColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
