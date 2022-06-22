import 'package:airplane/models/destination_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/used_seat_cubit.dart';
import '../../shared/theme.dart';
import '../../ui/widgets/photo_items.dart';
import '../../ui/widgets/custom_button.dart';
import '../../ui/widgets/interest_items.dart';
import 'choose_seat_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.destination}) : super(key: key);

  final DestinationModel destination;

  @override
  Widget build(BuildContext context) {
    Widget customBackgroundPictures() {
      return Container(
        height: 450,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(destination.imageUrl))),
      );
    }

    Widget gradientShadow() {
      return Container(
        height: 214,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 236),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              kWhiteColor.withOpacity(0),
              Colors.black.withOpacity(0.95)
            ])),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          children: [
            // EMBLEM
            Container(
                height: 24,
                width: 108,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image_emblem.png')))),

            // TITLE
            Container(
                margin: const EdgeInsets.only(top: 256),
                child: Row(children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(destination.nameDestination,
                            style: whiteTextStyle.copyWith(
                                fontSize: 24, fontWeight: semibold),
                            overflow: TextOverflow.ellipsis),
                        Text(destination.city,
                            style: whiteTextStyle.copyWith(
                                fontSize: 16, fontWeight: light))
                      ],
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/icon_star.png')))),
                    Text(destination.rating.toString(),
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium))
                  ])
                ])),

            // CONTENT
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(defaultRadiusCard)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About
                  Text('About',
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: semibold)),
                  const SizedBox(height: 6),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce facilisis libero lectus, sit amet pretium tellus fermentum et. Integer malesuada velit quis lacus convallis mollis. Phasellus ut nisi a libero condimentum molestie vel et sapien.',
                      style: blackTextStyle.copyWith(height: 2)),
                  const SizedBox(height: 20),

                  // Photos
                  Text('Photos',
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: semibold)),
                  const SizedBox(height: 6),
                  Row(children: const [
                    PhotoItems(imageUrl: 'assets/default_image.jpg'),
                    PhotoItems(imageUrl: 'assets/default_image.jpg'),
                    PhotoItems(imageUrl: 'assets/default_image.jpg')
                  ]),
                  const SizedBox(height: 20),

                  // Interests
                  Text('Interests',
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: semibold)),
                  const SizedBox(height: 10),
                  Row(children: const [
                    InterestItems(text: 'Kids Park'),
                    InterestItems(text: 'Honor Bridge'),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: const [
                    InterestItems(text: 'City Museum'),
                    InterestItems(text: 'Central Mall'),
                  ])
                ],
              ),
            ),

            // PRICE & BOOK BUTTON
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    decimalDigits: 0,
                                    symbol: 'IDR ')
                                .format(destination.price),
                            style: blackTextStyle.copyWith(
                                fontSize: 18, fontWeight: medium)),
                        const SizedBox(height: 5),
                        Text('per orang',
                            style: greyTextStyle.copyWith(fontWeight: light))
                      ],
                    ),
                  ),
                  CustomButton(
                      width: 170,
                      text: 'Book Now',
                      onPressed: () {
                        context
                            .read<UsedSeatCubit>()
                            .fetchUsedSeats(destination);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChooseSeatPage(destination)));
                      })
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [customBackgroundPictures(), gradientShadow(), content()],
        ),
      ),
    );
  }
}
