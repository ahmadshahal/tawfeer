import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/login_cubit/login_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/obscure_text_cubit/obscure_text_cubit.dart';
import 'package:tawfeer/src/business_logic/utils/validation_utility.dart';
import 'package:tawfeer/src/ui/components/loading_dialog.dart';
import 'package:tawfeer/src/ui/components/my_material_button.dart';
import 'package:tawfeer/src/ui/components/my_text_form_field.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    Image.asset(
                      'assets/images/tawfeer.png',
                      width: 210.0,
                      height: 160.0,
                    ),
                    const SizedBox(height: 35.0),
                    const Text(
                      'Welcome to Tawfeer!',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Spend your money wisely!',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: MyColors.darkGrey,
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    BlocListener<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSubmitting) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return const LoadingDialog();
                            },
                          );
                        } else if (state is LoginSuccess) {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/home');
                        } else if (state is LoginFailure) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text((state.exception.message + '.'))));
                        }
                      },
                      child: _form(context),
                    ),
                    const SizedBox(height: 5.0),
                    _registerRow(context),
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
          _emailTextFormField(context),
          const SizedBox(height: 15.0),
          BlocProvider(
            create: (context) => ObscureTextCubit(),
            child: _passwordTextFormField(context),
          ),
          const SizedBox(height: 25.0),
          _materialButton(context),
        ],
      ),
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
            return ValidationUtility.validateLoginPassword(value ?? "");
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
            splashRadius: 0.1, // Don't want a splash radius :)
          ),
        );
      },
    );
  }

  Widget _materialButton(BuildContext context) {
    return MyMaterialButton(
      text: 'Login',
      callBack: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<LoginCubit>(context).submit(
              email: _emailController.text, password: _passwordController.text);
        }
      },
    );
  }

  Widget _registerRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 14.0,
            color: MyColors.darkGrey,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/register',
            );
          },
          child: const Text(
            'Register',
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
