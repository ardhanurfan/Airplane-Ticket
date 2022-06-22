import 'package:airplane/models/destination_model.dart';
import 'package:airplane/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class PopulerDestinationCard extends StatelessWidget {
  const PopulerDestinationCard({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final DestinationModel destination;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    destination: destination,
                  ))),
      child: Container(
        height: 323,
        width: 200,
        margin: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadiusCard)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 20, left: 10, right: 10),
              height: 220,
              width: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(destination.imageUrl),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(defaultRadiusCard)),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 30,
                    width: 54.5,
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultRadiusCard),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/icon_star.png')))),
                        Text(destination.rating.toString(),
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium))
                      ],
                    ),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(destination.nameDestination,
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium),
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 5),
                  Text(destination.city,
                      style: greyTextStyle.copyWith(
                          fontSize: 14, fontWeight: light)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
