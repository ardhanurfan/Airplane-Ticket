import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/destination_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/destination_model.dart';
import '../../shared/theme.dart';
import '../widgets/top_destination_card.dart';
import '../widgets/populer_destination_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Header and Profile
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            // print(state.user.email);
            return Container(
              padding: EdgeInsets.only(
                  top: 30, right: defaultMargin, left: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text('Howdy,\n${state.user.name}',
                              style: blackTextStyle.copyWith(
                                  fontSize: 24, fontWeight: semibold),
                              overflow: TextOverflow.ellipsis)),
                      ClipOval(
                        child: Container(
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
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('Where to fly today?',
                      style: greyTextStyle.copyWith(
                          fontSize: 16, fontWeight: light))
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    // Slider
    Widget populerDestination(List<DestinationModel> destinations) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 30, left: 24),
          child: Row(
              children: destinations.map((e) {
            return PopulerDestinationCard(destination: e);
          }).toList()),
        ),
      );
    }

    // TOP Destination
    Widget topDestination(List<DestinationModel> destinations) {
      // Membuat Top Destination Hanya 5 terurut
      List<DestinationModel> sortdestination = [...destinations];

      sortdestination.sort(((a, b) => b.rating.compareTo(a.rating)));
      final topdestination = sortdestination.getRange(0, 5);

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Rating This Year',
                style: blackTextStyle.copyWith(
                    fontSize: 18, fontWeight: semibold)),
            Column(
              children: topdestination.map((e) {
                return TopDestinationCard(destination: e);
              }).toList(),
            ),
            const SizedBox(height: 140),
          ],
        ),
      );
    }

    return BlocConsumer<DestinationCubit, DestinationState>(
      listener: (context, state) {
        if (state is DestinationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: kRedColor,
            content: Text(state.error),
          ));
        }
      },
      builder: (context, state) {
        if (state is DestinationSuccess) {
          return Scaffold(
            body: SafeArea(
                child: ListView(
              children: [
                header(),
                populerDestination(state.destinations),
                topDestination(state.destinations),
              ],
            )),
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        );
      },
    );
  }
}
