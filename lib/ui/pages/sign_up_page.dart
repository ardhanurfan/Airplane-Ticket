import 'package:airplane/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:airplane/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/page_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/form_input.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController hobbyController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30, bottom: 30),
        child: Text(
          'Join us and get\nyour next journey',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
        ),
      );
    }

    Widget inputSection() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: kWhiteColor,
        ),
        child: Column(
          children: [
            FormInput(
                title: 'Full Name',
                hintText: 'Your full name',
                controller: nameController),
            FormInput(
                title: 'Email Address',
                hintText: 'Your email address',
                controller: emailController),
            FormInput(
              title: 'Password',
              hintText: 'Your password',
              obscureForm: true,
              controller: passwordController,
            ),
            FormInput(
                title: 'Hobby',
                hintText: 'Your hobby',
                controller: hobbyController),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  context.read<PageCubit>().setPage(0);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/bonus', (route) => false);
                } else if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 1),
                    backgroundColor: kRedColor,
                    content: Text(state.error),
                  ));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  );
                }
                return CustomButton(
                  width: double.infinity,
                  onPressed: () {
                    if (nameController.text == '' ||
                        hobbyController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: kRedColor,
                        content: Text('Forms cannot be empty'),
                      ));
                    } else {
                      context.read<AuthCubit>().signUp(
                            email: emailController.text,
                            name: nameController.text,
                            password: passwordController.text,
                            hobby: hobbyController.text,
                          );
                    }
                  },
                  text: 'Get Started',
                  margin: const EdgeInsets.only(top: 10),
                );
              },
            )
          ],
        ),
      );
    }

    Widget tacButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-in');
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 50, bottom: 73),
          child: Text(
            "Have an account? Sign In",
            style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
                decoration: TextDecoration.underline),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [title(), inputSection(), tacButton()],
        ),
      ),
    );
  }
}
