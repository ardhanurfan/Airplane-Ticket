import 'package:airplane/models/destination_model.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../../ui/pages/detail_page.dart';

class TopDestinationCard extends StatelessWidget {
  const TopDestinationCard({Key? key, required this.destination})
      : super(key: key);

  final DestinationModel destination;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DetailPage(
                    destination: destination,
                  )))),
      child: Container(
        height: 90,
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 10),
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadiusCard)),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(destination.imageUrl),
                              fit: BoxFit.cover),
                          borderRadius:
                              BorderRadius.circular(defaultRadiusCard))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.nameDestination,
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: medium),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(destination.city,
                          style: greyTextStyle.copyWith(
                              fontSize: 14, fontWeight: light))
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20,
                    width: 20,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icon_star.png')))),
                Text(destination.rating.toString(),
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
