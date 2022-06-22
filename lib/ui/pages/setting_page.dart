import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/ui/pages/edit_profile_page.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Column(
              children: [
                // Picture Profile
                ClipOval(
                  child: (state.user.imagePath == '')
                      ? Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/image_profile.png'),
                            ),
                          ),
                        )
                      : Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(state.user.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  state.user.name,
                  style: blackTextStyle.copyWith(
                      fontSize: 18, fontWeight: semibold),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Email : ',
                      style: greyTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    )),
                    Text(state.user.email)
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Hobby : ',
                      style: greyTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    )),
                    Text(state.user.hobby)
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }
        },
      );
    }

    Widget editProfileButton() {
      return Center(
          child: CustomButton(
        margin: const EdgeInsets.only(top: 48),
        width: 220,
        text: 'Edit Profile',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ));
        },
      ));
    }

    Widget signOutButton() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: kRedColor,
              content: Text(state.error),
            ));
          } else if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
          }
        },
        builder: (context, state) {
          return Center(
              child: CustomButton(
            margin: const EdgeInsets.only(top: 16),
            width: 220,
            text: 'Sign Out',
            onPressed: () {
              context.read<AuthCubit>().signOut();
            },
          ));
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 60),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
              color: kWhiteColor,
            ),
            child: Column(
              children: [
                content(),
                editProfileButton(),
                signOutButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
