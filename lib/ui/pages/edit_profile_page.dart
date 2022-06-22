import 'dart:io';
import 'package:airplane/cubit/image_profile_cubit.dart';
import 'package:airplane/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/page_cubit.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/form_input.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30, bottom: 30),
        child: Text(
          'Edit\nyour account',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
        ),
      );
    }

    Widget inputSection() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            context.read<ImageProfileCubit>().setImage(state.user.imagePath);
            final TextEditingController nameController =
                TextEditingController(text: state.user.name);
            final TextEditingController hobbyController =
                TextEditingController(text: state.user.hobby);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                color: kWhiteColor,
              ),
              child: Column(
                children: [
                  BlocBuilder<ImageProfileCubit, String>(
                    builder: (context, state) {
                      return ClipOval(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(state),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // EDIT BUTTON
                  Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 16),
                    child: TextButton(
                        onPressed: () async {
                          final file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (file != null) {
                            File filetemp = File(file.path);
                            String imagePath =
                                await UserService().uploadImage(filetemp);
                            // ignore: use_build_context_synchronously
                            context
                                .read<ImageProfileCubit>()
                                .setImage(imagePath);
                          } else {}
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(defaultRadius))),
                        child: Text(
                          'Edit',
                          style: whiteTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium),
                        )),
                  ),

                  // FORMS
                  FormInput(
                      title: 'Full Name',
                      hintText: 'Your full name',
                      controller: nameController),
                  FormInput(
                    title: 'Hobby',
                    hintText: 'Your hobby',
                    controller: hobbyController,
                  ),

                  CustomButton(
                    width: double.infinity,
                    onPressed: () {
                      context.read<AuthCubit>().updateUser(
                          nameController.text,
                          hobbyController.text,
                          context.read<ImageProfileCubit>().state);
                      context.read<PageCubit>().setPage(3);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/main', (route) => false);
                    },
                    text: 'Save',
                    margin: const EdgeInsets.only(top: 10),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                        onPressed: () {
                          context.read<PageCubit>().setPage(3);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/main', (route) => false);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                        ),
                        child: Text(
                          'Cancle',
                          style: purpleTextStyle.copyWith(
                              fontSize: 18, fontWeight: medium),
                        )),
                  )
                ],
              ),
            );
          } else {
            // return const CircularProgressIndicator(color: kPrimaryColor);
            return const SizedBox();
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [title(), inputSection()],
        ),
      ),
    );
  }
}
